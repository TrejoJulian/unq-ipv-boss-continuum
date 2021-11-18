extends TextureButton


func initialize(icon, number, name, max_score):
	$Icon.texture = load(icon)
	$Number.text = number
	$Name.text = name
	$MaxScore.text = "Max Score: %s" % max_score
