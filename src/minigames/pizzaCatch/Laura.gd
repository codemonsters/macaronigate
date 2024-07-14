extends Node2D
var instances = 1
signal pizza_catched

# Called when the node enters the scene tree for the first time.
func _ready():
	pizza_catched.connect(Callable(get_parent(), "on_pizza_catched"))

func _on_rigid_body_2d_body_entered(_body):
	emit_signal("pizza_catched", self)
