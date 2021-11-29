extends Area2D

class_name Note

export (PackedScene) var ghost_note_scene:PackedScene

onready var animated_sprite = $AnimatedSprite
var direction
export var speed:float = 100

var hit = false


func _physics_process(delta):
	if !hit:
		position.x += speed * delta


#note_direction < 0 is left and > 0 is right.
func initialize(pos, note_direction, is_up):
	direction = note_direction
	global_position = pos
	if note_direction > 0 :
		if(is_up):
			animated_sprite.frame = 3
		else:
			animated_sprite.frame = 2
		self.rotation_degrees = 180
		speed = -speed
	elif note_direction < 0:
		if(is_up):
			animated_sprite.frame = 1
		else:
			animated_sprite.frame = 0
	else:
		printerr("Invalid direction set for note: " + note_direction)
		return


func destroy(score):
	hit = true
	spawnGhost()
	queue_free()

func spawnGhost():
	var ghost_note = ghost_note_scene.instance()
	
	get_parent().add_child(ghost_note)
	ghost_note.set_as_toplevel(true)
	ghost_note.initialize(global_position, direction, animated_sprite.frames.get_frame("default",animated_sprite.frame))


func bad_area_entered():
	queue_free()

