extends Sprite2D

var activated

func _ready():
	activated = false

func _on_pressed():
	if activated:
		texture = load("res://minigames/panelDeBotones/switchOFF.png")
	else:
		texture = load("res://minigames/panelDeBotones/switchON.png")
	activated = !activated

