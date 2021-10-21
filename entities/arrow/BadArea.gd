extends Area2D

func _on_BadArea_area_entered(area):
	if area.is_in_group("note"):
		area.bad_area_entered()
		get_parent().handle_miss()
