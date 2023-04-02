extends Enemy

@export var stun_duration: float = 3


func _process(delta: float) -> void:
	super._process(delta)
	if sprite.scale.x == 1:
		$PlayerDetector.position = Vector2(40,0)
		$DamageArea.position = Vector2(34,6)
	elif sprite.scale.x == -1:
		$PlayerDetector.position = Vector2(-40,0)
		$DamageArea.position = Vector2(-50,6)

func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		sprite.play("jaw_open")

func _on_player_detector_body_exited(body: Node2D) -> void:
	if body is Player:
		$DamageArea/CollisionShape2D.disabled = true
		sprite.play("jaw_close")

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "jaw_open":
		$DamageArea/CollisionShape2D.disabled = false
	elif sprite.animation == "jaw_close":
		sprite.play("default")



func _on_damage_area_body_entered(body: Node2D) -> void:
	if body is Player:
		body.stun(stun_duration)
