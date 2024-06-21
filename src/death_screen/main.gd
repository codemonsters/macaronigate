extends Node2D


func _on_touch_screen_button_pressed():
	get_parent().get_parent().leave_death_screen()
