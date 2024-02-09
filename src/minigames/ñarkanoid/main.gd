extends Node2D

signal game_over
signal game_cleared

@export var game_brief = "Para la bola!!!"
@export var needs_timer = true # False if your game doesn't need a countdown timer
@export var timer_seconds = 5 # Only set if needs_timer = true

var paddle_moving_left = false
var paddle_moving_right = false


# Called when the node enters the scene tree for the first time.
func _ready():
	game_over.connect(Callable(get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent(), "on_game_cleared"))

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
	
	
func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			if event.position[0] < get_viewport().get_visible_rect().size[0] / 2:
				paddle_moving_left = true
				paddle_moving_right = false
			else:
				paddle_moving_left = false
				paddle_moving_right = true
		else:
			paddle_moving_left = false
			paddle_moving_right = false
	elif event.is_action_pressed("move_left"):
		paddle_moving_left = true
	elif event.is_action_released("move_left"):
		paddle_moving_left = false
	elif event.is_action_pressed("move_right"):
		paddle_moving_right = true
	elif event.is_action_released("move_right"):
		paddle_moving_right = false


func _on_floor_body_entered(body):
	if body.get_name() == "ball":
		emit_signal("game_over")

func on_game_timeout():
	emit_signal("game_cleared")
