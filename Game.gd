extends Node

onready var arrow_manager = $ArrowManager
onready var player = $Player
onready var audio_player = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	GameData.initialize()
	GameStatus.initialize()
	$HealthTimer.start()
	GameData.connect("depleted", self, "end_level")
	arrow_manager.connect("miss", player, "handle_miss")
	arrow_manager.connect("go_up", player, "jump_up")
	arrow_manager.connect("go_down", player, "jump_down")
	GameData.connect("streak_changed", player, "on_streak_changed")
	player.connect("streak_emited", self, "on_streak_emited")
	$Roadmap.initialize(Global.current_level.map_path)
	$Roadmap.connect("level_ended", self, "end_level")


func _on_HealthTimer_timeout():
	if GameData.current > 1:
		GameData.current -= 1


func end_level():
	if GameData.current != 0:
		GameStatus.won = true
		GameStatus.set_score(GameData.score)
		Global.update_level_max_score(GameData.score)
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	Global.goto_scene("res://end/EndScreen.tscn")



func on_streak_emited(streak):
	add_child(streak)
