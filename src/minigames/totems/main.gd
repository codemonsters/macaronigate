extends Node2D

@export var game_brief = "Match"
@export var needs_timer = true 
@export var timer_seconds = 15
@export var instruction_type = "tap"

signal game_over
signal game_cleared

signal game_timeout

func _ready():
	game_over.connect(Callable(get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent(), "on_game_cleared"))

func _on_timer_timeout():
	game_timeout.emit()

func _on_end_game():
	game_over.emit()


func _on_win_game():
	game_cleared.emit()
