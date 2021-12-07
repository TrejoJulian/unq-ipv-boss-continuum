extends Control

signal level_exited()

onready var health_bar = $HealthBar
onready var score = $Score
onready var popup_panel = $PopupPanel

func _ready():
	GameData.connect("changed", health_bar, "set_value")
	GameData.connect("max_changed", health_bar, "set_max")
	GameData.connect("score_changed", score, "set_value")


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().paused = true
			popup_panel.show()

func _on_Resume_pressed():
	resume_game()

func _on_Exit_pressed():
	resume_game()
	emit_signal("level_exited")

func resume_game():
	popup_panel.hide()
	get_tree().paused = false
	
