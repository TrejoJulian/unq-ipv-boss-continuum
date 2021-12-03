extends Node

onready var bad_area_bottom = $BadAreaBottom
onready var bad_area_top = $BadAreaTop
onready var right_arrow = $ArrowRight
onready var left_arrow = $ArrowLeft
onready var feedback_text = $FeedbackText
onready var note_sfx = $NoteSfx
onready var discharge_sfx = $DischargeSfx
signal miss
signal go_up
signal go_down
signal left_arrow_connected
signal right_arrow_connected

var is_up:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	left_arrow.connect("score_increased",self,"increase_score")
	left_arrow.connect("score_increased", feedback_text, "on_left_arrow_button_pressed")
	left_arrow.connect("miss",self,"handle_miss")
	left_arrow.connect("note_connected",self,"notify_left_arrow_connect")
	right_arrow.connect("score_increased",self,"increase_score")
	right_arrow.connect("score_increased", feedback_text, "on_right_arrow_button_pressed")
	right_arrow.connect("miss",self,"handle_miss")
	right_arrow.connect("note_connected",self,"notify_right_arrow_connect")
	bad_area_bottom.connect("miss",self,"handle_miss")
	bad_area_top.connect("miss",self,"handle_miss")


func increase_score(n):
	GameData.current += 5
	GameData.note_streak += 1
	GameData.score += n  
	GameStatus.count_note()
	play_note_audio()


func handle_miss():
	if GameData.mode == GameData.MODE.HARDCORE:
		GameData.current -= 100
	GameData.current -= 10
	GameData.note_streak = 0
	GameStatus.count_note()
	emit_signal("miss")
	play_miss_audio()

func _unhandled_input(event):
	if event.is_action_pressed("up"):
		if not is_up:
			_go_up()
		else:
			_go_down()
	if event.is_action_pressed("down"):
		if is_up:
			_go_down()
		else:
			_go_up()

func play_note_audio():
	note_sfx.play()

func _go_up():
	is_up = true
	right_arrow.position.y = bad_area_top.position.y
	left_arrow.position.y = bad_area_top.position.y
	right_arrow.set_is_up(true)
	left_arrow.set_is_up(true)
	emit_signal("go_up")

func _go_down():
	is_up = false
	right_arrow.position.y = bad_area_bottom.position.y
	left_arrow.position.y = bad_area_bottom.position.y
	right_arrow.set_is_up(false)
	left_arrow.set_is_up(false)
	emit_signal("go_down")

func play_miss_audio():
	discharge_sfx.play()

func notify_left_arrow_connect():
	emit_signal("left_arrow_connected")

func notify_right_arrow_connect():
	emit_signal("right_arrow_connected")
