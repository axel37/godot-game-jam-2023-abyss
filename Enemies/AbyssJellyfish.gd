extends Enemy

@export var damage: float = 15
@export var stun_duration: float = 1.25

@onready var impact_particles: GPUParticles2D = %ImpactParticles

func _on_tentacles_body_entered(body: Node2D) -> void:
	if body is Player:
		impact_particles.emitting = true
		body.stun(stun_duration)
		body.add_heat(damage)
