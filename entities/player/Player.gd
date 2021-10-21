extends Node2D

onready var player = $AnimatedSprite
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	player.play("idle")

func handle_miss():
	player.play("miss")
	yield(player, "animation_finished")
	player.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
