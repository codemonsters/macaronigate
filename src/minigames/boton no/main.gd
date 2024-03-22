extends Node2D
signal game_over
signal game_cleared

# Required variables
@export var game_brief = "Don't touch it!"
@export var needs_timer = true # False if your game doesn't need a countdown timer
@export var timer_seconds = 2 # Only set if needs_timer = true


# Called when the node enters the scene tree for the first time.
func _ready():
# Connect the appropriate signals to the funtions in game.gd
	game_over.connect(Callable(get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent(), "on_game_cleared"))
	$Button.disabled = true
	#$NoTouch.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_game_start():
	$Button.disabled = false

func on_game_timeout():
	game_cleared.emit()

func _on_button_pressed():
	game_over.emit()
