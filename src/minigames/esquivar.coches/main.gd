extends Node2D

@export var game_brief = "Don't crash!"
@export var needs_timer = false
@export var instructions_type = "touch_left_or_right"

var in_game = false

func on_game_start():
	in_game = true
