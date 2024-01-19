extends Node2D
var obj
signal meteor_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	meteor_pressed.connect(Callable(get_parent(), "on_meteor_pressed"))


func _on_button_pressed():
	emit_signal("meteor_pressed", self)
