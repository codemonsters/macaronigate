extends Node2D

@export var game_brief = "Match"
@export var needs_timer = true 
@export var timer_seconds = 15
@export var instructions_type = "tap"
var instructions_tap_positions : Array[Vector2] = [ Vector2(160, 1010), Vector2(360, 1010), Vector2(560, 1010) ]


signal chain_timeout


func on_game_timeout():
	chain_timeout.emit()

func on_game_start():
	$moradoBoton.disabled = false
	$rosaBoton.disabled = false
	$naranjaBoton.disabled = false

