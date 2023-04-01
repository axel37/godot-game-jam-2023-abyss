extends CharacterBody2D

# Player config
@export var dash_speed = 200
@export var rotation_speed = 0.1

# Instance variables
@onready var dash_particles: GPUParticles2D = %DashParticles
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
	move_and_slide()
	
	velocity *= 0.9


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
