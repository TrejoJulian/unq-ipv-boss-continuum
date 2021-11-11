extends Control

signal go_to_levels()


func _on_StartButton_pressed():
	emit_signal("go_to_levels")
