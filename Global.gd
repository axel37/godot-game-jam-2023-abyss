extends Node

# The currently loaded scene. Usually, this is the level.
var current_scene: Node2D

func _ready() -> void:
	# Get current scene
	# From : "Custom scene switcher" - Godot Docs
	# https://docs.godotengine.org/en/latest/tutorials/scripting/singletons_autoload.html#custom-scene-switcher
	##  "Both the current scene and autoloads are children of root, but autoloaded nodes are always first.
	##  This means that the last child of root is always the loaded scene."
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path: String):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	
	_deferred_goto_scene.call_deferred(path)
#	call_deferred(_deferred_goto_scene, path)


func _deferred_goto_scene(path: String):
	# It is now safe to remove the current scene
	current_scene.free()
	# Load the new scene.
	var s = ResourceLoader.load(path)
	# Instance the new scene.
	current_scene = s.instantiate()
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)
	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
