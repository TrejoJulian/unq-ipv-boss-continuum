extends Node

signal max_changed(new_max)
signal changed(max_amount)
signal depleted()

var max_amount setget set_max
var current setget set_current

func initialize():
	max_amount = 100
	current = max_amount

func set_max(new_max):
	max_amount = max(1, new_max)
	emit_signal("max_changed", max_amount)
	
func set_current(new_val):
	current = clamp(new_val, 0, max_amount)	
	emit_signal("changed", current)
	if current == 0:
		emit_signal("depleted")
