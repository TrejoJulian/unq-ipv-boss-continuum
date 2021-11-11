extends Control

onready var main_menu: Control = $VBoxContainer/MainMenu
onready var levels_menu: Control = $VBoxContainer/LevelsMenu
onready var score_label = $VBoxContainer/HBoxContainer/Score

func _ready():
	main_menu.connect("go_to_levels", self, "_on_go_to_levels")
	self.initialize_score()
	main_menu.show()
	levels_menu.hide()
	
	
func _on_go_to_levels():
	main_menu.hide()
	levels_menu.show()

func initialize_score():
	if GameStatus.score == 0:
		score_label.hide()
	else:
		score_label.text = "Previous Score: " + str(GameStatus.score)


func _on_ExitButton_pressed():
	get_tree().quit()
