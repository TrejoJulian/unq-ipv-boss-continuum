extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.


func _physics_process(delta):
	$LeftSideNoteSpawner.spawn($ArrowLeft.global_position)
	$RightSideNoteSpawner.spawn($ArrowRight.global_position)
