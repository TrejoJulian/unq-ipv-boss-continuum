extends Area2D

signal miss

func _on_BadArea_area_entered(area):
	if area.is_in_group("note"):
		area.bad_area_entered()
		emit_signal("miss")
