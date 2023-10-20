extends Area2D


func _ready():
	var rng = RandomNumberGenerator.new()
	
	var factor = null
	var camino = rng.randi_range(0, 1)
	
	if camino == 0:
		factor = -1
	else:
		factor = 1
	
	position.x = 165 * factor


func _process(delta):
	position.y = position.y + 15
