extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$NoteTimer.start()


func _physics_process(delta):
	pass
#	$LeftSideNoteSpawner.spawn()
#	$RightSideNoteSpawner.spawn()


func update_score(n):
	score += n


func _on_RightNoteTimer_timeout():
	$LeftSideNoteSpawner.spawn()
	$RightSideNoteSpawner.spawn()
