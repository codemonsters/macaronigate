extends Node2D

@export var game_brief = "Match"
@export var needs_timer = true 
@export var timer_seconds = 15
@export var instruction_type = "touch_left_or_right"

signal chain_timeout

func on_game_timeout():
  chain_timeout.emit()


