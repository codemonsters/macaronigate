extends Node2D
var raton = 0
var line = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rigid_body_2d_mouse_entered(raton):
	raton = 1
	print(raton)

func _on_rigid_body_2d_mouse_exited(raton):
	raton = 0
	print (raton)

func _on_rigid_body_2d_body_entered(Area2D):
	line = 1
	print(line)

func _on_rigid_body_2d_body_exited(Area2D):
	line = 0
	print(line)

func _on_input_event(raton, event, line):
	if event is InputEventMouseButton:
		if raton == 1:
			if line == 1:
				print("mec mec")
