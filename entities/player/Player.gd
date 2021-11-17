extends Node2D

#onready var player = $AnimatedSprite
onready var player:Sprite = $PlayerSprite
onready var ghost_1:Sprite = $Ghost1
onready var ghost_2:Sprite = $Ghost2
onready var ghost_3:Sprite = $Ghost3
onready var player_animation = $AnimationPlayer
onready var ghost_timer = $GhostTimer

export var vertical_up_position:float = 191.0
export var vertical_bottom_position:float = 430.0



func _ready():
	_play_animation("idle")

func _physics_process(delta):
	ghost_1.global_position = ghost_1.global_position.linear_interpolate(player.global_position,.3)
	ghost_2.global_position = ghost_2.global_position.linear_interpolate(ghost_1.global_position,.3)
	ghost_3.global_position = ghost_3.global_position.linear_interpolate(ghost_2.global_position,.3)

func handle_miss():
	_play_animation("Miss")
	yield(player_animation, "animation_finished")
	_play_animation("Idle")

func jump_up():
	_show_ghosts()
	player.global_position.y = vertical_up_position
	ghost_timer.start()


func jump_down():
	_show_ghosts()
	player.global_position.y = vertical_bottom_position
	ghost_timer.start()

func _play_animation(animation_name:String, should_restart:bool = true, playback_speed:float = 1.0):
	if player_animation.has_animation(animation_name):
		if should_restart:
			player_animation.stop()
		player_animation.playback_speed = playback_speed
		player_animation.play(animation_name)

func _show_ghosts():
	ghost_1.visible = true
	ghost_2.visible = true
	ghost_3.visible = true

func _hide_ghosts():
	ghost_1.visible = false
	ghost_2.visible = false
	ghost_3.visible = false


func _on_GhostTimer_timeout():
	_hide_ghosts()
