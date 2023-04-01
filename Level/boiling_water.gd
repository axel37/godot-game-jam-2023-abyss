extends StaticBody2D

@export var speed: float = 10

func _physics_process(delta):
	position.y += speed * delta
