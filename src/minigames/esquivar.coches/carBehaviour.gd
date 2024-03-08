extends Area2D

var main

func _ready():
	main = get_parent().get_parent()
	
	var rng = RandomNumberGenerator.new()
	
	var factor = null
	var camino = rng.randi_range(0, 1)
	
	if camino == 0:
		factor = -1
	else:
		factor = 1
	
	position.x = 165 * factor


func _process(delta):
	if (main.in_game == true):
		position.y = position.y + (1000 * delta)
