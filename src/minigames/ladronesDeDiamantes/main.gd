extends Node3D

signal game_over
signal game_cleared

var lostFlag = false

@export var game_brief = "Wait!"
@export var needs_timer = true
@export var timer_seconds = 6

func _ready():
	game_over.connect(Callable(get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent(), "on_game_cleared"))


func on_game_timeout():
	lostFlag = true
	game_over.emit()


func _on_game_lose():
	lostFlag = true
	game_over.emit()


func _on_game_win():
	if (!lostFlag):
		game_cleared.emit()
