extends Position2D

export (PackedScene) var note_scene:PackedScene
export (String) var note_direction:String = "Right"


func spawn():
	var note = note_scene.instance()
	
	add_child(note)
	note.set_as_toplevel(true)
	note.initialize(global_position, note_direction)
	
	return note


