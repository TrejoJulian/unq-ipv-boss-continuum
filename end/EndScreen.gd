extends Node

onready var winning_background_image = preload("res://assets/background/Fondo_Win.jpg")
onready var losing_background_image = preload("res://assets/background/Fondo_Lose.jpg")
onready var score_screen = $ScoreScreen
onready var gameover_screen = $GameOverScreen
onready var end_background = $AudioStreamPlayer
onready var background_image = $CanvasLayer/Background
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
		background_image.texture = winning_background_image
		gameover_screen.hide()
		score.text = "Score: %s" % GameStatus.score
		rank.text = "Rank\n%s" % ranks[GameStatus.rank()]
		medal.texture = load(medals[GameStatus.rank()])
		end_background.pitch_scale = 1.2
	else:
		score_screen.hide()
		background_image.texture = losing_background_image
		gameover_screen.show()
		end_background.pitch_scale = 0.7

func _on_Restart_pressed():
	end_background.stop()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	Global.goto_scene("res://Game.tscn")


func _on_Exit_pressed():
	end_background.stop()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	Global.goto_scene("res://menu/Menu.tscn")
