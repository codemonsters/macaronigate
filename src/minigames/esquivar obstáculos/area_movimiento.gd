extends Area2D

signal mouse_touch

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_touch.connect(Callable(get_parent().get_parent(), "on_area_movimiento_mouse_touch"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _unhandled_input(event):
	if event is InputEventScreenTouch:
		mouse_touch.emit()
