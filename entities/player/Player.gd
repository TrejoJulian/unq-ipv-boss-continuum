extends Node2D

var floaty_text_scene = preload("res://gui/FloatingText.tscn")

onready var player:Sprite = $PlayerSprite
onready var ghost_1:Sprite = $Ghost1
onready var ghost_2:Sprite = $Ghost2
onready var ghost_3:Sprite = $Ghost3
onready var player_animation = $AnimationPlayer
onready var ghost_timer = $GhostTimer
onready var back_particles = $PlayerSprite/BackParticles
onready var front_particles = $PlayerSprite/FrontParticles
export var vertical_up_position:float = 191.0
export var vertical_bottom_position:float = 430.0

var left_dance_moves = [
						"Dance_left_1",
						"Dance_left_2", 
						"Dance_left_3", 
						"Dance_left_4", 
						"Dance_left_5"
						]
						
var right_dance_moves = [
						"Dance_right_1",
						"Dance_right_2", 
						"Dance_right_3", 
						"Dance_right_4", 
						"Dance_right_5",
						"Dance_right_6"
						]

signal streak_emited(streak)

func _ready():
	_play_animation("idle")
	


func _physics_process(delta):
	ghost_1.global_position = ghost_1.global_position.linear_interpolate(player.global_position,.3)
	ghost_2.global_position = ghost_2.global_position.linear_interpolate(ghost_1.global_position,.3)
	ghost_3.global_position = ghost_3.global_position.linear_interpolate(ghost_2.global_position,.3)

func handle_miss():
	if player_animation.is_playing():
		player_animation.stop()
	_play_animation("Miss")
	yield(player_animation, "animation_finished")
	_play_animation("Idle")

func dance_left():
	dance(left_dance_moves)

func dance_right():
	dance(right_dance_moves)

func dance(moves):
	var random_animation:String = moves[randi()%(moves.size())]
	_play_animation(random_animation)
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

func on_streak_changed(streak):
	if (streak != 0):
		var floaty_text = floaty_text_scene.instance()
		floaty_text.global_position = player.global_position
		floaty_text.velocity = Vector2(rand_range(-50, 50), -100)
		floaty_text.modulate = Color(rand_range(0.7, 1), rand_range(0.7, 1), rand_range(0.7, 1), 1.0)
		floaty_text.text = str(streak)
		emit_signal("streak_emited", floaty_text)
	back_particles.visible = streak >= 50
	front_particles.visible = streak >= 50


func _on_GhostTimer_timeout():
	_hide_ghosts()
