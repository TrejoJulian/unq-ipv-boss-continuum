extends Control

export (PackedScene) var level_button_scene
onready var level_container = $MarginContainer/VBoxContainer/LevelContainer

func _ready():
	for i in Global.levels:
		var new_level_button = level_button_scene.instance()
		new_level_button.initialize(Global.levels[i].sprite, str(i), Global.levels[i].name, Global.levels[i].max_score)
		level_container.add_child(new_level_button)
		new_level_button.connect("pressed", self, "_on_go_to_level", [i])
		

func _on_go_to_level(level_id):
	Global.current_level = Global.levels[level_id]
	Global.goto_scene("res://Game.tscn")
