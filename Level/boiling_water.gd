extends Area2D

@export var speed: float = 10


func _physics_process(delta):
	position.y += speed * delta
	
	var colliding_bodies = get_overlapping_bodies()
	
	for body in colliding_bodies:
		if body is CharacterBody2D:
			body.position.y += speed * delta
