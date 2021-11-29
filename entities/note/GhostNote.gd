extends Sprite


#note_direction < 0 is left and > 0 is right.
func initialize(pos, note_direction, sprite):
	global_position = pos
	if note_direction > 0 :
		self.rotation_degrees = 180
	self.texture = sprite
	$LifeTimer.start()
	$AnimationPlayer.play("fade")
	


func _on_LifeTimer_timeout():
	queue_free()
