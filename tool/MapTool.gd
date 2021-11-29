extends Node

# var left_timer_uptime:float = 0.0
# var right_timer_uptime:float  = 0.0
var move_timer_uptime:float  = 0.0
var left_array = []
var right_array = []
var move_timer_timeouts = []
export var timer_interval = 0.05
var actual_time = 0.0


# func _on_LeftTimer_timeout():
# 	left_timer_uptime = left_timer_uptime + timer_interval


# func _on_RightTimer_timeout():
# 	right_timer_uptime = right_timer_uptime + timer_interval


func _process(delta):
	actual_time += delta


func _on_MoveTimer_timeout():
	move_timer_uptime = move_timer_uptime + timer_interval


func _unhandled_input(event):
	if event.is_action_pressed("left_arrow_pressed", false):
		left_array.append(actual_time)
	elif event.is_action_pressed("right_arrow_pressed", false):
		right_array.append(actual_time)
	elif event.is_action_pressed("up", false):
		move_timer_timeouts.append(move_timer_uptime)
		move_timer_uptime = 0
	elif event.is_action_pressed("down"):
		print(left_array)
		print(right_array)
		print(move_timer_timeouts)

