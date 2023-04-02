extends Enemy


func _on_player_detector_body_entered(body: Node2D) -> void:
	sprite.play("bounce")


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "bounce":
		sprite.play("default")
