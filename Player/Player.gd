extends CharacterBody2D

# Player config
@export var dash_speed = 200
@export var rotation_speed = 0.1
@export var stun_duration_multiplier = 0.5

# Instance variables
@onready var dash_particles: GPUParticles2D = %DashParticles

var collision_particles: PackedScene = preload("res://Particles/collision_particles.tscn")

var is_dashing: bool = false
var current_dash_speed: float = 0
var is_stunned: bool = false
var remaining_stun_duration: float = 0

func _physics_process(delta):
	if is_stunned:
		remaining_stun_duration -= delta
		if remaining_stun_duration <= 0:
			is_stunned = false
	
	if not is_stunned:
		if Input.is_action_pressed("rotate_left"):
			rotate(-rotation_speed)
		if Input.is_action_pressed("rotate_right"):
			rotate(rotation_speed)
		
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
		# The higher the velocity, the longer the stun
		stun(collision.get_remainder().length())
		# Spawn particles
		spawn_collision_particles()
		# Force stop dash
		stop_dash()
		# Bounce the player
		velocity = velocity.bounce(collision.get_normal()) * 2

# Stun the player for the specified duration
func stun(duration):
	is_stunned = true
	remaining_stun_duration = duration * stun_duration_multiplier

func spawn_collision_particles():
	var particle_instance = collision_particles.instantiate()
	add_child(particle_instance)
	particle_instance.emitting = true

func start_dash():
	is_dashing = true
	current_dash_speed = dash_speed
	dash_particles.emitting = true

func stop_dash():
	is_dashing = false
	current_dash_speed = 0
	dash_particles.emitting = false

func process_dash():
	velocity = transform.x * current_dash_speed
	current_dash_speed -= dash_speed / 50
	if current_dash_speed <= 0:
		stop_dash()
