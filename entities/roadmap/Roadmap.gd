extends Node


export var top_spawner_height:float = 290
export var bottom_spawner_height:float = 480

onready var left_note_spawner = $LeftSideNoteSpawner
onready var right_note_spawner = $RightSideNoteSpawner
onready var right_note_timer = $RightNoteTimer
onready var left_note_timer = $LeftNoteTimer
onready var moving_timer = $MovingTimer
onready var audio_player = $AudioStreamPlayer

var map_path:String

# Import JSON Note Map
var left_map = null
var right_map = null
var moving_map = null
var left_timeouts = 0
var right_timeouts = 0
var moving_timeouts = 0

var time_begin
var left_time_begin
var right_time_begin
var time_delay
var elapsed_time

var first_note_spawned

signal level_ended
signal first_note_emited

func initialize(incoming_map_path:String):
	map_path = incoming_map_path
	_start()

func _load_map():
	var map = File.new()
	map.open(map_path, map.READ)
	var json = map.get_as_text()
	var json_result = JSON.parse(json).result
	map.close()
	
	return json_result
	

func _ready():
	set_process(false)


func _start():

	var map = _load_map()
	
	self.right_map = map["right"]
	self.left_map = map["left"]
	self.moving_map = map["move"]
	
	# Sincronizar el tiempo real con el delay.
	audio_player.stream = load(Global.current_level.track)
	audio_player.play()
	
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	elapsed_time = -time_delay
	
	set_process(true)
	
	moving_timer.wait_time = moving_map[moving_timeouts]
	self.moving_timeouts += 1
#

	moving_timer.start()
	moving_timer.wait_time = moving_map[moving_timeouts]
	self.moving_timeouts += 1

func _process(delta):
	# Obtain from ticks.
	elapsed_time += delta

	print("Time is: ", elapsed_time)
	
	_spawn_note_if_apply(right_map,right_note_spawner)
	_spawn_note_if_apply(left_map,left_note_spawner)


func _spawn_note_if_apply(map, spawner):
	if !map.empty() && elapsed_time >= map.front():
		spawner.spawn()
		map.pop_front()
		if(!first_note_spawned):
			emit_signal("first_note_emited")
			self.first_note_spawned = true



func _on_MovingTimer_timeout():
	if(moving_timeouts % 2 != 0):
		self._move_spawners_to_the_bottom()
	else:
		self._move_spawners_to_the_top()
	moving_timer.wait_time = moving_map[moving_timeouts]
	self.moving_timeouts += 1
	if(len(moving_map) - 1 < self.moving_timeouts):
		moving_timer.stop()


func _move_spawners_to_the_top():
	left_note_spawner.position.y = top_spawner_height
	right_note_spawner.position.y = top_spawner_height
	left_note_spawner.set_is_up(true)
	right_note_spawner.set_is_up(true)


func _move_spawners_to_the_bottom():
	left_note_spawner.position.y = bottom_spawner_height
	right_note_spawner.position.y = bottom_spawner_height
	left_note_spawner.set_is_up(false)
	right_note_spawner.set_is_up(false)


func _on_AudioStreamPlayer_finished():
	audio_player.stop()
	emit_signal("level_ended")
