extends Marker2D

# The starting range of possible offsets using random values
@export var shake_strength: float = 10.0
# Multiplier for lerping the shake strength to zero
@export var decay_rate: float = 5.0

@onready var rand = RandomNumberGenerator.new()

var current_shake_strength: float = 0.0

func _ready() -> void:
	rand.randomize()

func apply_shake(strength: float, decay: float) -> void:
	shake_strength = strength
	decay_rate = decay
	current_shake_strength = shake_strength

func _process(delta: float) -> void:
	# Fade out the intensity over time
	if current_shake_strength > 0:
		current_shake_strength = lerpf(current_shake_strength, 0, decay_rate * delta)
		
		position = get_random_offset()

func get_random_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-current_shake_strength, current_shake_strength),
		rand.randf_range(-current_shake_strength, current_shake_strength)
	)
