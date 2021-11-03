extends Control

onready var health_bar = $HealthBar

func _ready():
	GameData.connect("changed", health_bar, "set_value")
	GameData.connect("max_changed", health_bar, "set_max")
