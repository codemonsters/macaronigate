extends Node2D

func _ready():
	$AnimationPlayer.play("main")
	
func _on_animation_player_animation_finished(anim_name):
	get_parent().on_intro_developer_finished()
