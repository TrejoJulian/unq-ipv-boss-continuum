extends ProgressBar

export (Color) var healthy_color = Color.green
export (Color) var caution_color = Color.yellow
export (Color) var danger_color = Color.red

export (int) var caution_value = 50
export (int) var danger_value = 20


func _ready():
	set_bg_color(healthy_color)

func _on_HealthBar_value_changed(new_health):
	if new_health > caution_value:
		set_bg_color(healthy_color)
	elif new_health > danger_value:
		set_bg_color(caution_color)
	else:
		set_bg_color(danger_color)


func set_bg_color(new_bg_color):
	var styleBox = get("custom_styles/fg")
	styleBox.bg_color = new_bg_color
