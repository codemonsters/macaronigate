extends Sprite2D


var activated

func _ready():
	activated = false

func _on_pressed():
	if activated:
		texture = load("res://minigames/panelDeBotones/redSwitchOFF.png")
	else:
		texture = load("res://minigames/panelDeBotones/redSwitchON.png")
	activated = !activated
