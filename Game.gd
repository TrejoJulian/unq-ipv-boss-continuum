extends Node2D


# Declare member variables here. Examples:
var score = 0
var note_streak = 0

onready var health = $Health
onready var score_label = $Score
onready var streak_label = $Streak

export var first_left_timeout:float = 27.7
export var first_right_timeout:float = 27.9

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
	self.left_map = self._load_map("left")
	self.right_map = self._load_map("right")

	$RightNoteTimer.wait_time = first_right_timeout
	$LeftNoteTimer.wait_time = first_left_timeout
	$HealthTimer.wait_time = 0.33
	$RightNoteTimer.start()
	$LeftNoteTimer.start()
	
	$RightNoteTimer.wait_time = right_map[right_timeouts]
	self.right_timeouts += 1
	$LeftNoteTimer.wait_time = left_map[left_timeouts]
	self.left_timeouts += 1
	
	print(self.left_map)
	print(self.right_map)


func increase_score(n):
	health.current += 5
	note_streak += 1
	score += n
	score_label.text ="Score: " + str(score)
	streak_label.text ="Streak: " + str(note_streak)  


func handle_miss():
	_decrease_health(10)
	note_streak = 0
	streak_label.text ="Streak: " + str(note_streak) 
	$Player.handle_miss()


func _on_RightNoteTimer_timeout():
	$HealthTimer.start()
	$RightSideNoteSpawner.spawn()
	$RightNoteTimer.wait_time = right_map[right_timeouts]
	self.right_timeouts += 1
	if(len(right_map) - 1 < self.right_timeouts):
		$RightNoteTimer.stop()
		print("right stop")


func _on_LeftNoteTimer_timeout():
	$LeftSideNoteSpawner.spawn()
	$LeftNoteTimer.wait_time = left_map[left_timeouts]
	self.left_timeouts += 1
	if(len(left_map) - 1 < self.left_timeouts):
		$LeftNoteTimer.stop()
		print("left stop")


func _on_HealthTimer_timeout():
	if health.current > 1:
		_decrease_health(1)


func _decrease_health(amount):
	health.current -= amount
	if health.current == 0:
		GameStatus.set_score(score)
		Global.goto_scene("res://Menu.tscn")
