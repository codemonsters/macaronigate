extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_input_event(_viewport, _event, _shape_idx):
	pass
	## print(event)
	## if event == InputEventMouseMotion && event.button_mask == 1:
	#$AnimatedSprite2D.set_frame_and_progress(1,1)
	#$Cortar_manzana.play()

func _on_button_pressed():
	$AnimatedSprite2D.set_frame_and_progress(1,1)
	$Cortar_manzana.play()
