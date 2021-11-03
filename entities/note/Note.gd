extends Area2D

class_name Note

export var speed:float = 100
export var perfect_text: String = "PERFECT"
export var perfect_text_colour: Color = Color("f6d6bd")
export var great_text: String = "GREAT"
export var great_text_colour: Color = Color("c3a38a")
export var okay_text: String = "OKAY"
export var okay_text_colour: Color = Color("997577")


var hit = false
onready var label = $Node2D/Label

func _physics_process(delta):
	if !hit:
		position.x += speed * delta

	else:
		$Node2D.position.y -= speed * delta

#note_direction < 0 is left and > 0 is right.
func initialize(pos, note_direction):
	global_position = pos
	if note_direction > 0 :
		$AnimatedSprite.frame = 1
		speed = -speed
	elif note_direction < 0:
		$AnimatedSprite.frame = 0
	else:
		printerr("Invalid direction set for note: " + note_direction)
		return


func destroy(score):
	$Timer.start()
	hit = true
	if score == 3:
		label.text = perfect_text
		label.modulate = Color("f6d6bd")
	elif score == 2:
		label.text = great_text
		label.modulate = Color("c3a38a")
	elif score == 1:
		label.text = okay_text
		label.modulate = Color("997577")


func bad_area_entered():
	queue_free()

func _on_Timer_timeout():
	queue_free()
