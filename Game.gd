extends Node

onready var arrow_manager = $ArrowManager
onready var player = $Player
onready var roadmap = $Roadmap
onready var gui = $GUI/GUI

enum STRATEGY {QUIT, WIN, LOSE}
var strategy = STRATEGY.WIN

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	GameData.initialize()
	GameStatus.initialize()
	GameData.connect("depleted", self, "lose_level")
	
	arrow_manager.connect("miss", player, "handle_miss")
	arrow_manager.connect("go_up", player, "jump_up")
	arrow_manager.connect("go_down", player, "jump_down")
	arrow_manager.connect("left_arrow_connected", player, "dance_left")
	arrow_manager.connect("right_arrow_connected", player, "dance_right")
	
	GameData.connect("streak_changed", player, "on_streak_changed")
	player.connect("streak_emited", self, "on_streak_emited")
	
	roadmap.initialize(Global.current_level.map_path)
	roadmap.connect("level_ended", self, "end_level")
	roadmap.connect("first_note_emited", self, "start_health_timer")
	
	gui.connect("level_exited", self, "quit_level")


func start_health_timer():
	$HealthTimer.start()
	

func _on_HealthTimer_timeout():
	if GameData.current > 1:
		GameData.current -= 1

func lose_level():
	strategy = STRATEGY.LOSE
	roadmap.stop_music()

func quit_level():
	strategy = STRATEGY.QUIT
	roadmap.stop_music()	
	
func end_level():
	var end_path = "res://end/EndScreen.tscn"
	if strategy == STRATEGY.LOSE:
		GameStatus.won = false
	elif strategy == STRATEGY.QUIT:
		end_path = "res://menu/Menu.tscn"
	else:
		GameStatus.set_score(GameData.score)
		Global.update_level_max_score(GameData.score)
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	Global.goto_scene(end_path)

