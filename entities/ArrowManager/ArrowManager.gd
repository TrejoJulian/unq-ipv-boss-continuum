extends Node


onready var right_arrow = $ArrowRight
onready var left_arrow = $ArrowLeft
signal miss


# Called when the node enters the scene tree for the first time.
func _ready():
	left_arrow.connect("score_increased",self,"increase_score")
	left_arrow.connect("miss",self,"handle_miss")
	right_arrow.connect("score_increased",self,"increase_score")
	right_arrow.connect("miss",self,"handle_miss")


func increase_score(n):
	GameData.current += 5
	GameData.note_streak += 1
	GameData.score += n  


func handle_miss():
	GameData.current -= 10
	GameData.note_streak = 0
	emit_signal("miss")

func _unhandled_input(event):
	if event.is_action_pressed("up"):
		right_arrow.position.y = $BadArea2.position.y
		left_arrow.position.y = $BadArea2.position.y
	if event.is_action_pressed("down"):
		right_arrow.position.y = $BadArea.position.y
		left_arrow.position.y = $BadArea.position.y
