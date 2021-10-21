extends Control

var next_scene = preload("res://Game.tscn")

func _on_TextureButton_pressed():
	get_tree().change_scene_to(next_scene)


func _on_ExitButton_pressed():
	get_tree().quit()
