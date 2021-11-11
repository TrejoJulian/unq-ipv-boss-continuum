extends TextureButton

func set_sprite(new_sprite):
	$TextureRect.texture = load(new_sprite)

func set_level_label(new_level_label):
	$LevelLabel.text = new_level_label
