extends Node2D

var paddle_moving_left = false
var paddle_moving_right = false


# Called when the node enters the scene tree for the first time.
func _ready():
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 0))	# Establecemos la dirección de la gravedad
	$ball.set_axis_velocity(Vector2(0, 1000));

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if paddle_moving_left and not paddle_moving_right:
		$Paddle.position += Vector2(-300, 0)*delta
	elif not paddle_moving_left and paddle_moving_right:
		$Paddle.position += Vector2(300, 0)*delta
	else:
		print("...")
		print($ball.get_position()[0])
	$ball.position = $ball.get_position()
	
	if $ball.get_position()[0] >= 720:
		print("se escapa")
		$ball.set_axis_velocity(Vector2(-1000, 0))
	
	if $ball.get_position()[0] <= 0:
		print("se escapa")
		$ball.set_axis_velocity(Vector2(1000, 0))
	
	if $ball.get_position()[1] >= 1280:
		print("se escapa")
		$ball.set_axis_velocity(Vector2(0, -1000))
		
	if $ball.get_position()[1] <= 0:
		print("se escapa")
		$ball.set_axis_velocity(Vector2(0, 1000))
	
func _input(event):
	if event is InputEventScreenTouch:
		#if event.is_pressed():
		if event.pressed == true:
			print("ha sido presseada en " + str(event.position[0]) + " y ancho de viewport = " +  str(get_viewport().get_visible_rect().size[0]))
			if event.position[0] < get_viewport().get_visible_rect().size[0] / 2:
				paddle_moving_left = true
				paddle_moving_right = false
			else:
				paddle_moving_left = false
				paddle_moving_right = true
		else:
			paddle_moving_left = false
			paddle_moving_right = false
