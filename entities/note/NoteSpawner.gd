extends Position2D

export (PackedScene) var note_scene:PackedScene
export (String) var note_direction:String = "Right"

#signal spawned(spawn)

func spawn():
	var note = note_scene.instance()
	
	add_child(note)
	note.set_as_toplevel(true)
	note.initialize(global_position, note_direction)
	
	#emit_signal("spawned",note) Esto es por si nos sirve a futuro
	return note


