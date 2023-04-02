extends Node2D

func _on_play_button_pressed() -> void:
	Global.goto_scene("Level/Level.tscn")

func _on_leave_button_pressed() -> void:
	get_tree().quit()
