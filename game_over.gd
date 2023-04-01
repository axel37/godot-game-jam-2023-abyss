extends Node2D

func _unhandled_input(event):
	if event.is_action_pressed("dash"):
		Global.goto_scene("Level/Level01.tscn")
