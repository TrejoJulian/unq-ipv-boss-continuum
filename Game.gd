extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$RightNoteTimer.start()


func _physics_process(delta):
	pass
#	$LeftSideNoteSpawner.spawn()
#	$RightSideNoteSpawner.spawn()


func _on_RightNoteTimer_timeout():
	$LeftSideNoteSpawner.spawn()
	$RightSideNoteSpawner.spawn()
