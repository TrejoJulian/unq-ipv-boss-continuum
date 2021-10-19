extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var total_notes = 0
var score = 0
var note_strike = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$RightNoteTimer.wait_time = 4
	$LeftNoteTimer.wait_time = 4
	$RightNoteTimer.start()
	$LeftNoteTimer.start()


func _physics_process(delta):
	pass


func increase_score(n):
	score += n
	
	
func handle_miss():
	note_strike = 0
	score -= 1


func _on_RightNoteTimer_timeout():
	total_notes += 1
	$RightSideNoteSpawner.spawn()
	if(total_notes <= 10):
		$RightNoteTimer.wait_time = randi()%6+3
	else:
		$RightNoteTimer.wait_time = randi()%4+1

func _on_LeftNoteTimer_timeout():
	total_notes += 1
	$LeftSideNoteSpawner.spawn()
	if(total_notes <= 5):
		$LeftNoteTimer.wait_time = randi()%6+3
	else:
		$LeftNoteTimer.wait_time = randi()%4+1
