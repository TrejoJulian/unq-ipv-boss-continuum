extends Node

export var first_left_timeout:float = 1
export var first_right_timeout:float = 1.825
export var top_spawner_height:float = 290
export var bottom_spanwer_height:float = 480

onready var left_note_spawner = $LeftSideNoteSpawner
onready var right_note_spawner = $RightSideNoteSpawner
onready var right_note_timer = $RightNoteTimer
onready var left_note_timer = $LeftNoteTimer

# Import JSON Note Map
var left_map = null
var right_map = null
var left_timeouts = 0
var right_timeouts = 0

func _load_map(side):
	var map = File.new()
	map.open("res://assets/map.json", map.READ)
	var json = map.get_as_text()
	var json_result = JSON.parse(json).result
	map.close()
	
	return json_result[side]
	



# Called when the node enters the scene tree for the first time.
func _ready():
	self.right_timeouts = 0
	self.left_timeouts = 0
	self.left_map = self._load_map("left")
	self.right_map = self._load_map("right")
	right_note_timer.wait_time = first_right_timeout
	left_note_timer.wait_time = first_left_timeout
	
	right_note_timer.start()
	left_note_timer.start()
	
	right_note_timer.wait_time = right_map[right_timeouts]
	self.right_timeouts += 1
	left_note_timer.wait_time = left_map[left_timeouts]
	self.left_timeouts += 1
	
	print(self.left_map)
	print(self.right_map)

func _on_RightNoteTimer_timeout():
	right_note_spawner.spawn()
	right_note_timer.wait_time = right_map[right_timeouts]
	self.right_timeouts += 1
	if(len(right_map) - 1 < self.right_timeouts):
		right_note_timer.stop()
		print("right stop")


func _on_LeftNoteTimer_timeout():
	left_note_spawner.spawn()
	left_note_timer.wait_time = left_map[left_timeouts]
	self.left_timeouts += 1
	if(len(left_map) - 1 < self.left_timeouts):
		left_note_timer.stop()
		print("left stop")

func _move_spawners_to_the_top():
	left_note_spawner.position.y = top_spawner_height
	right_note_spawner.position.y = top_spawner_height

func _move_spawners_to_the_bottom():
	left_note_spawner.position.y = bottom_spanwer_height
	right_note_spawner.position.y = top_spawner_height

