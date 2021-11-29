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


func _parse_map(map):
	var parsed_map = []
	var time = 0
	for i in map.size():
		time += map[i]
		parsed_map.push_back(time)
	return parsed_map


func _ready():
	set_process(false)


func _start():
	# Parsear el json. y usar pop front
	var parsed_json = _load_map()
	
	self.right_map = _parse_map(parsed_json["right"])
	self.left_map = _parse_map(parsed_json["left"])
	self.moving_map = _parse_map(parsed_json["move"])
	
	# Sincronizar el tiempo real con el delay.
	audio_player.stream = load(Global.current_level.track)
	audio_player.play()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()#probar antes y despues
	elapsed_time = -time_delay
	
	set_process(true)
	
#	right_note_timer.wait_time = right_map[right_timeouts]
#	self.right_timeouts += 1
#	left_note_timer.wait_time = left_map[left_timeouts]
#	self.left_timeouts += 1
	moving_timer.wait_time = moving_map[moving_timeouts]
	self.moving_timeouts += 1
#
#	right_note_timer.start()
#	left_note_timer.start()
	moving_timer.start()
#
#	right_note_timer.wait_time = right_map[right_timeouts]
#	self.right_timeouts += 1
#	left_note_timer.wait_time = left_map[left_timeouts]
#	self.left_timeouts += 1
	moving_timer.wait_time = moving_map[moving_timeouts]
	self.moving_timeouts += 1

func _process(delta):
	# Obtain from ticks.
	elapsed_time += delta

	print("Time is: ", elapsed_time)
	#parametrizar
	if !right_map.empty() && elapsed_time >= right_map.front():
		right_note_spawner.spawn()
		right_map.pop_front()
		if(!first_note_spawned):
			self.get_parent().start_healt_timer()
			self.first_note_spawned = true

	if !left_map.empty() && elapsed_time >= left_map.front():
		left_note_spawner.spawn()
		left_map.pop_front()
		if(!first_note_spawned):
			self.parent.start_healt_timer()
			self.first_note_spawned = true


#func _on_RightNoteTimer_timeout():
#	right_note_spawner.spawn()
#	right_note_timer.wait_time = right_map[right_timeouts]
#	self.right_timeouts += 1
#	if(len(right_map) - 1 < self.right_timeouts):
#		right_note_timer.stop()
#
#
#func _on_LeftNoteTimer_timeout():
#	left_note_spawner.spawn()
#	left_note_timer.wait_time = left_map[left_timeouts]
#	self.left_timeouts += 1
#	if(len(left_map) - 1 < self.left_timeouts):
#		left_note_timer.stop()


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
