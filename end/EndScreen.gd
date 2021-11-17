extends Node

onready var score_screen = $ScoreScreen
onready var gameover_screen = $GameOverScreen
onready var end_background = $AudioStreamPlayer

func _ready():
	if GameStatus.won:
		score_screen.show()
		gameover_screen.hide()
	else:
		score_screen.hide()
		gameover_screen.show()
		end_background.stream = load(Global.current_level.track)
		end_background.pitch_scale = 0.7
		end_background.play()


func _on_Restart_pressed():
	Global.goto_scene("res://Game.tscn")


func _on_Exit_pressed():
	Global.goto_scene("res://menu/Menu.tscn")
