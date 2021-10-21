extends AnimatedSprite

var perfect:bool = false
var great:bool = false
var okay:bool = false
var current_note:Note = null

var perfect_score: int = 3
var great_score: int = 2
var okay_score: int = 1

export var input:String = "left_arrow_pressed"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _unhandled_input(event):
	if event.is_action(input):
		if event.is_action_pressed(input, false):
			if current_note != null:
				if perfect:
					get_parent().increase_score(perfect_score)
					current_note.destroy(perfect_score)
				elif great:
					get_parent().increase_score(great_score)
					current_note.destroy(great_score)
				elif okay:
					get_parent().increase_score(okay_score)
					current_note.destroy(okay_score)
				_reset()
			else:
				get_parent().handle_miss()
		if event.is_action_pressed(input):
			frame = 1
		elif event.is_action_released(input):
			$PushTimer.start()


func _reset():
	current_note = null
	perfect = false
	great = false
	okay = false


func _on_PerfectArea_area_entered(area):
	if area.is_in_group("note"):
		perfect = true


func _on_PerfectArea_area_exited(area):
	if area.is_in_group("note"):
		perfect = false


func _on_GreatArea_area_entered(area):
	if area.is_in_group("note"):
		great = true


func _on_GreatArea_area_exited(area):
	if area.is_in_group("note"):
		great = false

#Al ser el area mas externa, esta es la que notifica que la nota ya esta "en rango"
func _on_OkayArea_area_entered(area):
	if area.is_in_group("note"):
		okay = true
		current_note = area


func _on_OkayArea_area_exited(area):
	if area.is_in_group("note"):
		okay = false
		current_note = null


func _on_PushTimer_timeout():
	frame = 0
