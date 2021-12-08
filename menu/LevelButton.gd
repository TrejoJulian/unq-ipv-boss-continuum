extends TextureButton


func initialize(icon, number, name, max_score):
	$Icon.texture = load(icon)
	$Name.text = name
	$MaxScore.text = "Max Score - %s" % max_score
