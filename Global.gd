extends Node

# The currently loaded scene. Usually, this is the level.
var current_scene: Node

func _ready() -> void:
	# Get current scene
	# From : "Custom scene switcher" - Godot Docs
	# https://docs.godotengine.org/en/latest/tutorials/scripting/singletons_autoload.html#custom-scene-switcher
	##  "Both the current scene and autoloads are children of root, but autoloaded nodes are always first.
	##  This means that the last child of root is always the loaded scene."
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
