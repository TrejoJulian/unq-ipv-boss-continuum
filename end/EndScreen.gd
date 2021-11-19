extends Node

onready var score_screen = $ScoreScreen
onready var gameover_screen = $GameOverScreen
onready var end_background = $AudioStreamPlayer

onready var score = $ScoreScreen/HBoxContainer/VBoxContainer/Score
onready var rank = $ScoreScreen/HBoxContainer/VBoxContainer2/Rank
onready var medal = $ScoreScreen/HBoxContainer/VBoxContainer2/Medal

export (Array, String) var medals
export (Array, String) var ranks

func _ready():
	end_background.stream = load(Global.current_level.track)
	self.choose_screen()
	end_background.play()

func choose_screen():
	if GameStatus.won:
		score_screen.show()
		gameover_screen.hide()
		score.text = "Score: %s" % GameStatus.score
		rank.text = "Rank\n%s" % ranks[GameStatus.rank()]
		medal.texture = load(medals[GameStatus.rank()])
		end_background.pitch_scale = 1.2
	else:
		score_screen.hide()
		gameover_screen.show()
		end_background.pitch_scale = 0.7

func _on_Restart_pressed():
	Global.goto_scene("res://Game.tscn")


func _on_Exit_pressed():
	Global.goto_scene("res://menu/Menu.tscn")
