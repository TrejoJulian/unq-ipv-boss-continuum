extends Node

onready var main_menu: Control = $VBoxContainer/MainMenu
onready var levels_menu: Control = $VBoxContainer/LevelsMenu
onready var bgm = $BackgroundPlayer

func _ready():
	main_menu.connect("go_to_levels", self, "_on_go_to_levels")
	levels_menu.connect("go_to_game", self, "_on_go_to_game")
	main_menu.show()
	levels_menu.hide()


func _on_go_to_levels():
	main_menu.hide()
	levels_menu.show()


func _on_ExitButton_pressed():
	bgm.stop()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	get_tree().quit()


func _on_go_to_game(level_id):
	Global.current_level = Global.levels[level_id]
	bgm.stop()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	Global.goto_scene("res://Game.tscn")
