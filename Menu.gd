extends Control


func _on_TextureButton_pressed():
	Global.goto_scene("res://Game.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
