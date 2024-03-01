extends Node2D
signal game_over
signal game_cleared
var cliks = 0 
@export var game_brief = "¡click!"
@export var needs_timer = true
@export var timer_seconds = 10

func _ready():
	game_over.connect(Callable(get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent(), "on_game_cleared")) 

func on_game_timeout():
	game_over.emit()

func _process(delta):
	pass


func _on_button_pressed():
	cliks += 1
	scale.x += 0.01
	scale.y += 0.01
	
	if cliks == 65:
		game_cleared.emit()
		visible = false
