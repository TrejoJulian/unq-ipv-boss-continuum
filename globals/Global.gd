extends Node

# var value 
var current_scene = null
var levels = {
		1: {
			"map_path": "res://assets/tuto.json",
			"track": "res://assets/music/Komiku_-_07_-_Run_against_the_universe.mp3",
			"sprite": "res://assets/character/Robot/PNG/Parts HD/head.png"
		},
		2: {
			"map_path": "res://assets/tuto.json",
			"track": "res://assets/music/Komiku_-_07_-_Run_against_the_universe.mp3",
			"sprite": "res://assets/character/Robot/PNG/Parts HD/headFocus.png"
		},
		3: {
			"map_path": "res://assets/radioactive.json",
			"track": "res://assets/music/radioactive.mp3",
			"sprite": "res://assets/character/Robot/PNG/Parts HD/headShock.png"
		}
	}
var current_level

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path, value=null):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
