extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.initialize()
	GameStatus.initialize()
	GameData.connect("depleted", self, "end_level")
	$ArrowManager.connect("miss", $Player, "handle_miss")
	$Roadmap.initialize(Global.current_level.map_path)
	$AudioStreamPlayer.stream = load(Global.current_level.track)
	$AudioStreamPlayer.play()

func _on_HealthTimer_timeout():
	if GameData.current > 1:
		GameData.current -= 1

func end_level():
	GameStatus.set_score(GameData.score)
	Global.goto_scene("res://end/EndScreen.tscn")
