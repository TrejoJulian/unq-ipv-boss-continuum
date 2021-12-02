extends Node

signal score_changed(new_score)
signal streak_changed(new_streak)
signal max_changed(new_max)
signal changed(max_amount)
signal depleted()

enum MODE {EASY, MEDIUM, HARDCORE}
var mode = MODE.MEDIUM
const modes = ["Easy", "Medium", "Hardcore"]

var max_amount setget set_max
var current setget set_current
var score setget set_score
var note_streak setget set_streak


func initialize():
	max_amount = 100
	current = max_amount
	score = 0
	note_streak = 0


func set_max(new_max):
	max_amount = max(1, new_max)
	emit_signal("max_changed", max_amount)


func set_current(new_val):
	if (mode != MODE.EASY):
		current = clamp(new_val, 0, max_amount)	
		emit_signal("changed", current)
		if current == 0:
			emit_signal("depleted")


func set_score(new_score):
	score = new_score
	emit_signal("score_changed", score)
	
func set_streak(new_streak):
	note_streak = new_streak
	emit_signal("streak_changed", note_streak)
