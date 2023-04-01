extends CharacterBody2D

# Player config
@export var dash_speed = 200
@export var rotation_speed = 0.1

# Instance variables
@onready var dash_particles: GPUParticles2D = %DashParticles

var collision_particles: PackedScene = preload("res://Particles/collision_particles.tscn")

var is_dashing: bool = false
var current_dash_speed: float = 0

func _physics_process(delta):
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
	if collision:
		var particle_instance = collision_particles.instantiate()
		add_child(particle_instance)
		particle_instance.emitting = true
		stop_dash()
		velocity = velocity.bounce(collision.get_normal()) * 2


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
