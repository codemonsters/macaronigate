extends CharacterBody2D

var velocidad = 500
var veloity = Vector2()
var mouse_position = null

func fisics_process (delta):
	
	veloity = Vector2(0 , 0)
	mouse_position = get_global_mouse_position()
	
	if Input.is_action_pressed("forward"):
		var direction = (mouse_position - position).normalized()
		veloity = direction*velocidad
		

