extends Node
export var map_path:String
export var left_side_start_delay:float
export var right_side_start_delay:float
export var track:AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.initialize()
	GameData.connect("depleted", self, "end_level")
	$ArrowManager.connect("miss", $Player, "handle_miss")
	$Roadmap.initialize(map_path,left_side_start_delay,right_side_start_delay)
	$AudioStreamPlayer.stream = track
	$AudioStreamPlayer.play()

func _on_HealthTimer_timeout():
	if GameData.current > 1:
		GameData.current -= 1

func end_level():
	GameStatus.set_score(GameData.score)
	Global.goto_scene("res://Menu.tscn")
