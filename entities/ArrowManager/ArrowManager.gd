extends Node

onready var bad_area_bottom = $BadAreaBottom
onready var bad_area_top = $BadAreaTop
onready var right_arrow = $ArrowRight
onready var left_arrow = $ArrowLeft
signal miss


# Called when the node enters the scene tree for the first time.
func _ready():
	left_arrow.connect("score_increased",self,"increase_score")
	left_arrow.connect("miss",self,"handle_miss")
	right_arrow.connect("score_increased",self,"increase_score")
	right_arrow.connect("miss",self,"handle_miss")
	bad_area_bottom.connect("miss",self,"handle_miss")
	bad_area_top.connect("miss",self,"handle_miss")


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
		right_arrow.position.y = bad_area_top.position.y
		left_arrow.position.y = bad_area_top.position.y
	if event.is_action_pressed("down"):
		right_arrow.position.y = bad_area_bottom.position.y
		left_arrow.position.y = bad_area_bottom.position.y
