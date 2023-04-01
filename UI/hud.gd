extends CanvasLayer

@onready var player: CharacterBody2D = Global.current_scene.find_child("Player")
@onready var heat_bar: ProgressBar = %HeatBar

func _process(delta):
	if player != null:
		heat_bar.value = player.current_heat
