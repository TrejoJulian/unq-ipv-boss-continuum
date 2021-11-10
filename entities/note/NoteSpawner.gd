extends Position2D

export (PackedScene) var note_scene:PackedScene
export (int) var note_direction:int = 1

var is_up = false


func spawn():
	var note = note_scene.instance()
	
	add_child(note)
	note.set_as_toplevel(true)
	note.initialize(global_position, note_direction, is_up)
	
	return note


func set_is_up(b):
	self.is_up = b
