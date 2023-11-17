extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$DissolveRect.get_node("AnimationPlayer").play("fade_in")
	$Title.get_node("AnimatedSprite2D").play("default")
	$PlayButton.get_node("AnimatedSprite2D").play("default")


func _on_play_button_pressed():
	print("PRESSED!")
	Globals.comenzar_partida()
