extends Enemy

@export var damage: float = 15
@export var stun_duration: float = 0.5

@onready var impact_particles: GPUParticles2D = %ImpactParticles

# Player enters bounce area
func _on_player_detector_body_entered(body: Node2D) -> void:
	sprite.play("bounce")

# Bounce animation over
func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "bounce":
		sprite.play("default")

# Player enters damage area
func _on_tentacles_body_entered(body: Node2D) -> void:
	if body is Player:
		impact_particles.emitting = true
		body.stun(stun_duration)
		body.add_heat(damage)
