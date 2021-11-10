extends Area2D

class_name Note

export var speed:float = 100



var hit = false

func _physics_process(delta):
	if !hit:
		position.x += speed * delta


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


func bad_area_entered():
	queue_free()

func _on_Timer_timeout():
	queue_free()
