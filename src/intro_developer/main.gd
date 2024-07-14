extends Node2D

func _ready():
	$AnimationPlayer.play("main")
	
func _on_animation_player_animation_finished(_anim_name):
	get_parent().on_intro_developer_finished()

func _input(event):
	if event is InputEventScreenTouch and event.pressed == true:
		get_parent().on_intro_developer_finished()
