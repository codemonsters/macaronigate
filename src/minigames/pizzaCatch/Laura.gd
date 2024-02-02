extends Node2D
var instances = 1
signal pizza_catched

# Called when the node enters the scene tree for the first time.
func _ready():
	pizza_catched.connect(Callable(get_parent(), "on_pizza_catched"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rigid_body_2d_body_entered(body):
	emit_signal("pizza_catched", self)
