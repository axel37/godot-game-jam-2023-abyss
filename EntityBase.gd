extends CharacterBody2D


# Create base of entitys
@export var hp_max = 100
@export var hp = hp_max
@export var defense = 0
@export var speed = 75


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	move_and_slide()
	
	
	


