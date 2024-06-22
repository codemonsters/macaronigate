extends Node3D

func _input(event):
	if event is InputEventScreenTouch and event.pressed == true:
		get_parent().leave_win_screen()
