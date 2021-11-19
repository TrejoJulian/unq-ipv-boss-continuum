extends Node

onready var arrow_manager = $ArrowManager
onready var player = $Player
onready var audio_player = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(1.0),"timeout")
	GameData.initialize()
	GameStatus.initialize()
	$HealthTimer.start()
	GameData.connect("depleted", self, "end_level")
	arrow_manager.connect("miss", player, "handle_miss")
	arrow_manager.connect("go_up", player, "jump_up")
	arrow_manager.connect("go_down", player, "jump_down")
	$Roadmap.initialize(Global.current_level.map_path)
	audio_player.stream = load(Global.current_level.track)
	audio_player.play()


func _on_HealthTimer_timeout():
	if GameData.current > 1:
		GameData.current -= 1


func end_level():
	audio_player.stop()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	Global.goto_scene("res://end/EndScreen.tscn")


func _on_AudioStreamPlayer_finished():
	if GameData.current != 0:
		GameStatus.won = true
		GameStatus.set_score(GameData.score)
		Global.update_level_max_score(GameData.score)
	self.end_level()
