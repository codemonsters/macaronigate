extends Node2D

var pipe_scene = load("res://minigames/flapuie biuegtwt/pipe.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pipes = $Pipes.get_children()
	for pipe in pipes:
		pipe.position.x -= 3
	


func _on_new_pipes_timer_timeout():
	# highest lower pipe Y: 800, lowest lower pipe Y: 1680
	# highest upper pipe Y: -400, lowest lower pipe Y: 480
	
	# TODO: expresanr la posición de una tubería respecto a la otra y añadir cierta aleatoriedad para que el alto del agujero sea variable
	
	var new_lower_pipe_instance = pipe_scene.instantiate()
	new_lower_pipe_instance.set_position(Vector2(720 + 50, 1680))
	$Pipes.add_child(new_lower_pipe_instance)
	
	var new_upper_pipe_instance = pipe_scene.instantiate()
	new_upper_pipe_instance.set_position(Vector2(720 + 50, 480))
	new_upper_pipe_instance.rotate(PI)
	$Pipes.add_child(new_upper_pipe_instance)
	
