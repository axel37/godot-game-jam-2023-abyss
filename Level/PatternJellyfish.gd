extends CharacterBody2D

@onready var path = %PathFollow2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	sprite.play("animated_jellyfish")



func _physics_process(delta):
	move_and_slide()
