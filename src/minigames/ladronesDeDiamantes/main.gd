extends Node3D

signal game_over
signal game_cleared

signal game_lose

var lostFlag = false

@export var game_brief = "Wait!"
@export var needs_timer = true
@export var timer_seconds = 11
@export var instruction_type = "tap"

func _ready():
	game_over.connect(Callable(get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent(), "on_game_cleared"))

func on_game_start():
	$Steal.disabled = false

func on_game_timeout():
	if !lostFlag:
		game_over.emit()
	lostFlag = true

func _on_game_lose():
	if !lostFlag:
		game_over.emit()
	lostFlag = true

func _on_game_win():
	if (!lostFlag):
		game_cleared.emit()
