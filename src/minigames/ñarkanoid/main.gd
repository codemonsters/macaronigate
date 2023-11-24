extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 0))	# Establecemos la dirección de la gravedad
	$ball.set_axis_velocity(Vector2(0, 1000));

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
