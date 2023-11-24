extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
#		if event.is_pressed():
		print(event)
		$AnimatedSprite2D.set_frame_and_progress(1,1)


func _on_mouse_entered():
	$AnimatedSprite2D.set_frame_and_progress(1,1)

#func _on_mouse_exited():
#	print("Mouse exited")


func _on_body_entered(body):
	print(body)

