extends Node2D
var direction = Vector2(0,1)
var angulo = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = Vector2(sin(angulo),cos(angulo))
