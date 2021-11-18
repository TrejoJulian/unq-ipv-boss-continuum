extends Node

onready var main_menu: Control = $VBoxContainer/MainMenu
onready var levels_menu: Control = $VBoxContainer/LevelsMenu

func _ready():
	main_menu.connect("go_to_levels", self, "_on_go_to_levels")
	main_menu.show()
	levels_menu.hide()
	
	
func _on_go_to_levels():
	main_menu.hide()
	levels_menu.show()

func _on_ExitButton_pressed():
	get_tree().quit()
