extends Node2D


func _ready():
	$AnimationPlayer.current_animation = "going_up"
	$arrowLight.play()
	


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "going_up":
		$AnimationPlayer.current_animation = "exiting_elevator"
	elif anim_name == "exiting_elevator":
		get_parent().get_parent().on_elevator_exit()
