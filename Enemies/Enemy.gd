class_name Enemy extends CharacterBody2D

@export var path_follower: PathFollow2D
@export var speed: float = 30

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var current_direction: int = 1

func _ready() -> void:
	# Force disable loop (which actually break our looping system)
	path_follower.loop = false

func _process(delta: float) -> void:
	global_position = path_follower.global_position

func _physics_process(delta: float) -> void:
	if path_follower.progress_ratio <= 0 or path_follower.progress_ratio >= 1:
		current_direction *= -1
		sprite.scale.x = current_direction
	path_follower.progress += speed * current_direction * delta
