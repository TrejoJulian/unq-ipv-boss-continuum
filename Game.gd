extends Node


# Declare member variables here. Examples:
var score = 0
var note_streak = 0

onready var score_label = $GUILayer/Score
onready var streak_label = $GUILayer/Streak

# Called when the node enters the scene tree for the first time.
func _ready():
	$RightNoteTimer.wait_time = 2
	$LeftNoteTimer.wait_time = 2
	$HealthTimer.wait_time = 0.33
	$RightNoteTimer.start()
	$LeftNoteTimer.start()
	$HealthTimer.start()




func increase_score(n):
	GameData.current += 5
	note_streak += 1
	score += n
	score_label.text ="Score: " + str(score)
	streak_label.text ="Streak: " + str(note_streak)  


func handle_miss():
	_decrease_health(10)
	note_streak = 0
	streak_label.text ="Streak: " + str(note_streak) 
	$Player.handle_miss()


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
	_decrease_health(1)

func _decrease_health(amount):
	GameData.current -= amount
	if GameData.current == 0:
		GameStatus.set_score(score)
		Global.goto_scene("res://Menu.tscn")
