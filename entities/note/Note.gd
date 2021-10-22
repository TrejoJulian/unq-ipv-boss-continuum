extends Area2D

class_name Note

export var speed:float = 100
var hit = false
onready var label = $Node2D/Label

func _physics_process(delta):
	if !hit:
		position.x += speed * delta

	else:
		$Node2D.position.y -= speed * delta


func initialize(pos, note_direction):
	global_position = pos
	if note_direction == "Right":
		$AnimatedSprite.frame = 1
		speed = -speed
	elif note_direction == "Left":
		$AnimatedSprite.frame = 0
	else:
		printerr("Invalid direction set for note: " + note_direction)
		return


func destroy(score):
	$Timer.start()
	hit = true
	if score == 3:
		label.text = "PERFECT"
		label.modulate = Color("f6d6bd")
	elif score == 2:
		label.text = "GREAT"
		label.modulate = Color("c3a38a")
	elif score == 1:
		label.text = "OKAY"
		label.modulate = Color("997577")


func bad_area_entered():
	queue_free()

func _on_Timer_timeout():
	queue_free()
