extends Node2D

var score:int         = 0
var note_count:int    = 0  # Esto se podria setear de afuera tambien. De momento hago que lo calcule en base a la cantidad de notas/fallos
export var perfect_note_score = 3

func initialize():
	score    = 0
	note_count = 0


func set_score(s):
	score = s

func rank():
	var rank = ""
	var mastery_level =  float(score) / _max_possible_score()
	if (mastery_level >= 0.9):
		rank = "S"
	elif (mastery_level >= 0.8):
		rank = "A"
	elif (mastery_level >= 0.7):
		rank = "B"
	else:
		rank = "C"
	return rank

func count_note():
	note_count += 1


func _max_possible_score():
	return note_count * perfect_note_score
