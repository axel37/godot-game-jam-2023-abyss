extends Camera2D

@onready var player: CharacterBody2D = %Player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null:
		position.y = player.position.y
