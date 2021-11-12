extends Node
export (AudioStream) var note_audio
export (AudioStream) var miss_audio


onready var bad_area_bottom = $BadAreaBottom
onready var bad_area_top = $BadAreaTop
onready var right_arrow = $ArrowRight
onready var left_arrow = $ArrowLeft
onready var feedback_text = $FeedbackText
onready var note_sfx = $NoteSfx
onready var discharge_sfx = $DischargeSfx
signal miss


# Called when the node enters the scene tree for the first time.
func _ready():
	left_arrow.connect("score_increased",self,"increase_score")
	left_arrow.connect("score_increased", feedback_text, "on_left_arrow_button_pressed")
	left_arrow.connect("miss",self,"handle_miss")
	right_arrow.connect("score_increased",self,"increase_score")
	right_arrow.connect("score_increased", feedback_text, "on_right_arrow_button_pressed")
	right_arrow.connect("miss",self,"handle_miss")
	bad_area_bottom.connect("miss",self,"handle_miss")
	bad_area_top.connect("miss",self,"handle_miss")


func increase_score(n):
	GameData.current += 5
	GameData.note_streak += 1
	GameData.score += n  
	GameStatus.count_note()
	play_note_audio()

func play_note_audio():
	note_sfx.stream = note_audio
	note_sfx.play()

func play_miss_audio():
	discharge_sfx.stream = miss_audio
	discharge_sfx.play()


func handle_miss():
	GameData.current -= 10
	GameData.note_streak = 0
	GameStatus.count_note()
	emit_signal("miss")
	play_miss_audio()

func _unhandled_input(event):
	if event.is_action_pressed("up"):
		right_arrow.position.y = bad_area_top.position.y
		left_arrow.position.y = bad_area_top.position.y
		right_arrow.set_is_up(true)
		left_arrow.set_is_up(true)
	if event.is_action_pressed("down"):
		right_arrow.position.y = bad_area_bottom.position.y
		left_arrow.position.y = bad_area_bottom.position.y
		right_arrow.set_is_up(false)
		left_arrow.set_is_up(false)
