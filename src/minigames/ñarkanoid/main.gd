extends Node2D

var paddle_moving_left = false
var paddle_moving_right = false


# Called when the node enters the scene tree for the first time.
func _ready():
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 0))	# Establecemos la dirección de la gravedad
	$ball.set_axis_velocity(Vector2(0, 1000));


func _physics_process(delta):
	$ball.linear_velocity = $ball.linear_velocity.normalized() * 50000 * delta
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# movimiento horizontal del juegador
	if paddle_moving_left and not paddle_moving_right:
		$Paddle.position += Vector2(-300, 0) * delta
	elif not paddle_moving_left and paddle_moving_right:
		$Paddle.position += Vector2(300, 0) * delta
	
	$Block.position.x = $ball.position.x	# la posición horizontal del bloque superior se corresponde siempre con el de la bola
	
	#if $ball.get_position()[1] >= 1280:
		#print("se escapa")
		#$ball.set_axis_velocity(Vector2(0, -1000))
	
	
func _input(event):
	if event is InputEventScreenTouch:
		#if event.is_pressed():
		if event.pressed == true:
			#print("ha sido presseada en " + str(event.position[0]) + " y ancho de viewport = " +  str(get_viewport().get_visible_rect().size[0]))
			if event.position[0] < get_viewport().get_visible_rect().size[0] / 2:
				paddle_moving_left = true
				paddle_moving_right = false
			else:
				paddle_moving_left = false
				paddle_moving_right = true
		else:
			paddle_moving_left = false
			paddle_moving_right = false


func _on_floor_body_entered(body):
	if body.get_name() == "ball":
		print("Bola detectada!")
