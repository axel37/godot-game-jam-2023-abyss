extends CharacterBody2D

@export var dash_speed = 200
@export var rotation_speed = 0.1

var is_dashing: bool = false
var current_dash_speed: float = 0

func _physics_process(delta):
	if Input.is_action_pressed("rotate_left"):
		rotate(-rotation_speed)
	if Input.is_action_pressed("rotate_right"):
		rotate(rotation_speed)

	if Input.is_action_just_pressed("dash") and not is_dashing:
		current_dash_speed = dash_speed
		is_dashing = true
	
	if is_dashing:
		velocity = transform.x * current_dash_speed
		current_dash_speed -= dash_speed / 50
		if current_dash_speed <= 0:
			is_dashing = false
			current_dash_speed = 0

	
	move_and_slide()
	
	velocity *= 0.9
