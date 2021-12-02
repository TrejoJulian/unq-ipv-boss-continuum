extends Node

var activated_fireworks: int = 0

func _ready():
	GameData.connect("score_changed", self, "activate_fireworks")

func activate_fireworks(new_score):
	if activated_fireworks < 4  && new_score > 200:
		activated_fireworks += 1
		$Firework4.play()
		GameData.disconnect("score_changed", self, "activate_fireworks")
	elif activated_fireworks < 3 && new_score > 150:
		activated_fireworks += 1
		$Firework3.play()
	elif activated_fireworks < 2 && new_score > 100:
		activated_fireworks += 1
		$Firework2.play()
	elif activated_fireworks < 1 && new_score > 50:
		activated_fireworks += 1
		$Firework1.play()
	else:
		return
