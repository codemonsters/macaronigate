extends CharacterBody2D

var color = 0           

func _ready():
	var rng = RandomNumberGenerator.new()
	color = rng.randi_range(0, 2)
	
	if color == 0:
		get_child(0).modulate = Color(0.5, 0, 1, 1)
	
	elif color == 1:
		get_child(0).modulate = Color(1, 0.5, 1, 1)
		
	else:
		get_child(0).modulate = Color(1, 0.5, 0, 1)
	
func get_color():
	return color
