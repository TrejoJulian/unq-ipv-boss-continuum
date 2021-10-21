extends Node2D


# Declare member variables here. Examples:
var health_bar = 100
var score = 0
var note_streak = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$RightNoteTimer.wait_time = 4
	$LeftNoteTimer.wait_time = 4
	$HealthTimer.wait_time = 0.5
	$RightNoteTimer.start()
	$LeftNoteTimer.start()
	$HealthTimer.start()


func _physics_process(delta):
	print(health_bar)
	print(score)
	print(note_streak)


func increase_score(n):
	health_bar += 5
	note_streak += 1
	score += n


func handle_miss():
	health_bar -= 10
	note_streak = 0
	


func _on_RightNoteTimer_timeout():
	$RightSideNoteSpawner.spawn()
	if(note_streak <= 10):
		$RightNoteTimer.wait_time = randi()%6+3
	else:
		$RightNoteTimer.wait_time = randi()%4+1

func _on_LeftNoteTimer_timeout():
	$LeftSideNoteSpawner.spawn()
	if(note_streak <= 10):
		$LeftNoteTimer.wait_time = randi()%6+3
	else:
		$LeftNoteTimer.wait_time = randi()%4+1


func _on_HealthTimer_timeout():
	health_bar -= 1
