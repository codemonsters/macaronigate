extends Area2D



func _ready():
	var rng = RandomNumberGenerator.new()
	
	var camino = rng.randi_range(-225, 120)
	
	position.y = camino

func _process(delta):
	position.x = position.x + (-1000*delta)
