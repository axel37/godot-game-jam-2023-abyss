class_name Player extends CharacterBody2D

signal died

# Player config
@export var dash_speed = 200
@export var swim_speed = 25
@export var rotation_speed = 0.06
@export var stun_duration_multiplier = 0.3
@export var max_heat: float = 100
@export var hot_zone_heat_multiplier: float = 6
@export var cool_down_multiplier: float = 3

# Instance variables
@onready var dash_particles_top: GPUParticles2D = %DashParticles
@onready var dash_particles_bottom: GPUParticles2D = %DashParticles2
@onready var sprite: AnimatedSprite2D = %Sprite
@onready var sprite_pivot: Marker2D = %SpritePivot

var collision_particles: PackedScene = preload("res://Particles/collision_particles.tscn")

var is_dashing: bool = false
var current_dash_speed: float = 0
var is_stunned: bool = false
var remaining_stun_duration: float = 0
var current_heat: float = 0
var is_in_hot_zone: bool = false
var is_dead: bool = false
var current_rotation_speed_multiplier: float = 1

func _physics_process(delta):
	# Don't process if we're dead
	if is_dead:
		return

	if current_heat > 0:
		add_heat(-1 * delta * cool_down_multiplier)

	if is_stunned:
		remaining_stun_duration -= delta
		if remaining_stun_duration <= 0:
			is_stunned = false
			sprite.play("default")

	if not is_stunned:
		if Input.is_action_pressed("rotate_left"):
			rotate(-rotation_speed * current_rotation_speed_multiplier)
			velocity = transform.x * swim_speed
		if Input.is_action_pressed("rotate_right"):
			rotate(rotation_speed * current_rotation_speed_multiplier)
			velocity = transform.x * swim_speed

		if Input.is_action_just_pressed("dash") and not is_dashing:
			start_dash()

	if is_dashing:
		process_dash()

	process_movement(delta)
	velocity *= 0.9


func process_movement(delta: float):
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	# If a collision occurs, bounce and stun the player
	if collision:
		# Force stop dash
		stop_dash()
		# The higher the velocity, the longer the stun
		stun(collision.get_remainder().length())
		# Spawn particles
		spawn_collision_particles()
		# Bounce the player
		var bounce: Vector2 = velocity.bounce(collision.get_normal())
		if bounce.length() < 200:
			bounce = bounce * 3
		velocity = bounce

# Stun the player for the specified duration
func stun(duration):
	var stun_duration = duration * stun_duration_multiplier

	is_stunned = true
	var tween: Tween = get_tree().create_tween()
	Engine.time_scale = 0.1
	tween.tween_property(Engine, 'time_scale', 1, stun_duration / 2)

	sprite.play("stun")
	sprite_pivot.apply_shake(duration * 8, duration * 12)
	remaining_stun_duration += stun_duration
	if remaining_stun_duration > 1.5:
		remaining_stun_duration = 1.5

func spawn_collision_particles():
	var particle_instance = collision_particles.instantiate()
	add_child(particle_instance)
	particle_instance.emitting = true

func start_dash():
	# Stretch sprite
	sprite_pivot.scale.x = 1.5
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(sprite_pivot, 'scale', Vector2(1,1), 0.5)
	# Do dash
	is_dashing = true
	sprite.play("dash")
	current_dash_speed = dash_speed
	dash_particles_top.emitting = true
	dash_particles_bottom.emitting = true

func stop_dash():
	is_dashing = false
	sprite.play("default")
	current_dash_speed = 0
	current_rotation_speed_multiplier = 1
	dash_particles_top.emitting = false
	dash_particles_bottom.emitting = false

func process_dash():
	velocity = transform.x * current_dash_speed
	current_dash_speed -= dash_speed / 50
	current_rotation_speed_multiplier = clamp(0.02 * current_dash_speed, 1, 2.5)
	if current_dash_speed <= 0:
		stop_dash()

func add_heat(amount: float):
	current_heat += amount
	if current_heat >= max_heat:
		die()

func die():
	is_dead = true
	died.emit()


func _on_heat_detector_in_hotzone(hot_zone: HotZone, delta: float):
	add_heat(hot_zone.heat_multiplier * hot_zone_heat_multiplier * delta)
