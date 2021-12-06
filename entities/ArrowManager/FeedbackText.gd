extends Control

onready var left_side_text_label = $LeftSideText
onready var right_side_text_label = $RightSideText
onready var left_text_timer = $LeftTextTimer
onready var right_text_timer = $RightTextTimer
onready var left_text_effect = $LeftTextEffect
onready var right_text_effect = $RightTextEffect

export var perfect_score:int = 3
export var great_score:int   = 2
export var okay_score:int    = 1
export var perfect_bbcode_text:String = "[wave][rainbow freq=2.5 val=1.3]Perfect"
export var great_bbcode_text:String = "[wave] Great"
export var okay_bbcode_text:String = "    Ok"
export var great_text_colour = Color("e2ef08")
export var default_text_colour = Color("ffffff")



func on_right_arrow_button_pressed(score):
	_change_text(right_side_text_label,text_from_score(score))
	right_text_effect.visible = true
	right_text_timer.start()

func on_left_arrow_button_pressed(score):
	_change_text(left_side_text_label,text_from_score(score))
	left_text_effect.visible = true
	left_text_timer.start()

func text_from_score(score):
	_change_text_colour(left_side_text_label, default_text_colour)
	_change_text_colour(right_side_text_label, default_text_colour)
	var text = ""
	if (score == perfect_score):
		text = perfect_bbcode_text
	elif(score == great_score):
		text = great_bbcode_text
	elif(score == okay_score):
		text = okay_bbcode_text
	return text 

func _change_text(label,text):
	label.bbcode_text = text
	if (text == great_bbcode_text):
		_change_text_colour(label, great_text_colour)
	

func _change_text_colour(label,colour):
	label.modulate = Color(colour)
	label.self_modulate = Color(colour)

func _on_RightTextTimer_timeout():
	_change_text(right_side_text_label,"")
	right_text_effect.visible = false


func _on_LeftTextTimer_timeout():
	_change_text(left_side_text_label,"")
	left_text_effect.visible = false

