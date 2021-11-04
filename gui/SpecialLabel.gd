extends Label

export (String) var data_name: String

func _ready():
	set_value(0)

func set_value(value):
	text = data_name + ": " + str(value)
