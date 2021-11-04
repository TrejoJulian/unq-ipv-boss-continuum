extends Control

onready var health_bar = $HealthBar
onready var score = $Score
onready var streak = $Streak

func _ready():
	GameData.connect("changed", health_bar, "set_value")
	GameData.connect("max_changed", health_bar, "set_max")
	GameData.connect("score_changed", score, "set_value")
	GameData.connect("streak_changed", streak, "set_value")
