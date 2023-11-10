extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$DissolveRect.get_node("AnimationPlayer").play("fade_in")


func _on_play_button_pressed():
	get_tree().change_scene("res://minigames/happyhippo/main.tscn")


func _on_fade_in_animation_finished(anim_name):
	# TODO: Despertar al menú (debería estar sleep = true en un inicio)
	pass
