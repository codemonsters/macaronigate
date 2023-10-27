extends CharacterBody2D

var color = 0           #0 = azul ,1 = amarillo , 3 = naranja 

func _ready():
	var rng = RandomNumberGenerator.new()
	color = rng.randi_range(0, 2)
	
	if color == 0:
		get_child(0).modulate = Color(0.941176, 0.9722549, 1, 1)
	
	elif color == 1:
		get_child(0).modulate = Color(0.941176, 1, 0.941176, 1)
		
	else:
		get_child(0).modulate = Color(1, 0.647059, 0, 1)
	
