extends Node2D

func _input(event):
	if event is InputEventScreenTouch and event.pressed == true:
		get_parent().leave_death_screen()
