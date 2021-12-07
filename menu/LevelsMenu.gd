extends Control

signal go_to_game(level_id)

export (PackedScene) var level_button_scene

onready var level_container = $MarginContainer/VBoxContainer/LevelContainer
onready var modes_dropdown = $MarginContainer/VBoxContainer/HBoxContainer/ModesDropdown


func _ready():
	for i in Global.levels:
		var new_level_button = level_button_scene.instance()
		new_level_button.initialize(Global.levels[i].sprite, str(i), Global.levels[i].name, Global.levels[i].max_score)
		level_container.add_child(new_level_button)
		new_level_button.connect("pressed", self, "_on_go_to_level", [i])
	_initialize_modes_dropdown()	
		
func _initialize_modes_dropdown():
	for mode in GameData.modes:
		modes_dropdown.add_item(mode)
	modes_dropdown.select(GameData.mode)


func _on_ModesDropdown_item_selected(id):
	GameData.mode = id


func _on_go_to_level(level_id):
	emit_signal("go_to_game", level_id)
