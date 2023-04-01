extends CharacterBody2D

@onready var path: Path2D = %Path2D


func _physics_process(delta):
	

#const SPEED = 25.0
#const JUMP = 400
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#
#func _physics_process(delta):
#
#	# Add gravity
#	if not is_on_floor():
#		velocity.y += gravity
#
#	move_and_slide()
#	velocity *= 0.9
#
#
#
#
#
#func _on_timer_timeout():
#	velocity.y = -JUMP
#	print(20)
