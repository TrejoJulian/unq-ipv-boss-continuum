extends AnimatedSprite

signal note_connected
signal score_increased(score)
signal miss
var current_note:Note = null
var score_counter: int = 0
var is_up = false


export var input:String = "left_arrow_pressed"


func _unhandled_input(event):

	if event.is_action_pressed(input, false):
		if current_note != null:
			emit_signal("score_increased",score_counter)
			emit_signal("note_connected")
			current_note.destroy(score_counter)
			_reset()
		else:
			emit_signal("miss")
	if event.is_action_pressed(input):
			if(self.is_up):
				frame = 3
			else:
				frame = 1
	elif event.is_action_released(input):
		$PushTimer.start()


func set_is_up(b):
	self.is_up = b
	if(self.is_up):
		set_frame(2)
	else:
		set_frame(0)


func _reset():
	current_note = null
	score_counter = 0


func _on_PerfectArea_area_entered(area):
	if area.is_in_group("note"):
		score_counter = score_counter + 1


func _on_PerfectArea_area_exited(area):
	if area.is_in_group("note"):
		score_counter = score_counter - 1


func _on_GreatArea_area_entered(area):
	if area.is_in_group("note"):
		score_counter = score_counter + 1


func _on_GreatArea_area_exited(area):
	if area.is_in_group("note"):
		score_counter = score_counter - 1

#Al ser el area mas externa, esta es la que notifica que la nota ya esta "en rango"
func _on_OkayArea_area_entered(area):
	if area.is_in_group("note"):
		score_counter = score_counter + 1
		current_note = area


func _on_OkayArea_area_exited(area):
	if area.is_in_group("note"):
		_reset()


func _on_PushTimer_timeout():
	if(self.is_up):
		frame = 2
	else:
		frame = 0
