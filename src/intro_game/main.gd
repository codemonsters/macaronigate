
# Background 2 https://depositphotos.com/editorial/city-street-buildings-background-people-walking-sidewalk-some-cars-parked-644604080.html

### Extensions

extends Node2D

### Code

func _ready():
	$AnimationPlayer.play("walking")

func _process(_delta):
	pass

func _input(event):
	if event is InputEventScreenTouch and event.pressed == true:
		get_parent().on_game_intro_finished()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "walking":
		$AnimationPlayer.play("chase")
	elif anim_name == "chase":
		$AnimationPlayer.play("entrance")
	elif anim_name == "entrance":
#		$AnimationPlayer.play("final")
#	elif anim_name == "final":
		get_parent().on_game_intro_finished()
