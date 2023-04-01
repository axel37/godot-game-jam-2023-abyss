extends CanvasLayer

@onready var player: CharacterBody2D = Global.current_scene.find_child("Player")
@onready var heat_bar: ProgressBar = %HeatBar
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _ready():
	Global.current_scene.find_child("Player").died.connect(game_over)

func _process(delta):
	if player != null:
		heat_bar.value = player.current_heat

func game_over():
	animation_player.play("fade_to_black")

# Called by animation
func game_over_change_scene():
	Global.goto_scene("game_over.tscn")
