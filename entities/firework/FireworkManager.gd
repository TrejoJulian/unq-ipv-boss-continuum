extends Node


func _ready():
	GameData.connect("streak_changed", self, "activate_fireworks")


func activate_fireworks(new_streak):
	for f in get_children():
		if new_streak == 0 and f.is_playing():
			f.set_all_loops(false)
		if f.start_streak == new_streak:
			if not f.is_playing():
				f.play()
			f.set_all_loops(true)
