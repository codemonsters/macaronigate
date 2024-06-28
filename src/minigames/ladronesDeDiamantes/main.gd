extends Node3D

signal game_over
signal game_cleared
signal move_camera

signal game_lose

var lostFlag = false

@export var game_brief = "Wait!"
@export var needs_timer = true
@export var timer_seconds = 11
@export var instructions_type = "tap"
var instructions_tap_positions : Array[Vector2] = [ Vector2(360, 1050) ]

func _ready():
	game_over.connect(Callable(get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent(), "on_game_cleared"))

func on_game_start():
	$Steal.disabled = false

func on_game_timeout():
	if !lostFlag:
		lostFlag = true
		game_over.emit()
		move_camera.emit()

func _on_game_lose():
	if !lostFlag:
		lostFlag = true
		game_over.emit()

func _on_game_win():
	if (!lostFlag):
		game_cleared.emit()
