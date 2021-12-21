extends Node2D

var score:int         = 0
var note_count:int    = 0  # Esto se podria setear de afuera tambien. De momento hago que lo calcule en base a la cantidad de notas/fallos
export var perfect_note_score = 3
var won: bool
var rank_score = 0

enum {S, A, B, C}


func initialize():
	score    = 0
	note_count = 0
	won = true
	rank_score = 0

func set_score(s):
	score = s


func rank():
	var rank
	var mastery_level =  float(rank_score) / _max_possible_score()
	if (mastery_level >= 0.9):
		rank = S
	elif (mastery_level >= 0.65):
		rank = A
	elif (mastery_level >= 0.4):
		rank = B
	else:
		rank = C
	return rank

func count_note():
	note_count += 1


func _max_possible_score():
	return perfect_note_score * note_count

