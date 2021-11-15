extends Node

var left_timer_uptime:float = 0.0
var right_timer_uptime:float  = 0.0
var left_timer_timeouts = []
var right_timer_timeouts = []
export var timer_interval = 0.05



func _on_LeftTimer_timeout():
	left_timer_uptime = left_timer_uptime + timer_interval


func _on_RightTimer_timeout():
	right_timer_uptime = right_timer_uptime + timer_interval

func _unhandled_input(event):
	if event.is_action_pressed("left_arrow_pressed", false):
		left_timer_timeouts.append(left_timer_uptime)
		left_timer_uptime = 0
	elif event.is_action_pressed("right_arrow_pressed", false):
		right_timer_timeouts.append(right_timer_uptime)
		right_timer_uptime = 0
	elif event.is_action_pressed("down"):
		print(left_timer_timeouts)
		print(right_timer_timeouts)

