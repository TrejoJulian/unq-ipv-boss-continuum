extends Control


func _ready():
	if GameStatus.score == 0:
		$Background/VBoxContainer/HBoxContainer/Score.hide()
	else:
		$Background/VBoxContainer/HBoxContainer/Score.text = "Previous Score: " + str(GameStatus.score)

func _on_TextureButton_pressed():
	Global.goto_scene("res://Game.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
