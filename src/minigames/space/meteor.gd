extends Node2D
var obj

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		for obj in get_children():
			if obj.is_in_group("needDelete"):
				remove_child(obj)
				obj.remove_from_group("needDelete")
				obj.queue_free()
