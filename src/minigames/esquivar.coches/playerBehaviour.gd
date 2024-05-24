extends CharacterBody2D

# AVISO: Cambié el nombre de la escena principal a "main"
# Señales para decirle a game.tscn si se ha terminado el juego
signal game_over
signal game_cleared

var posicion_jugador = 0
var win = false
var lose = false
var tamaño = true

func _ready():
	position = Vector2(-190, 417)
	
	# Inicializar el HUD y conectar las señales con las funciones correspondientes
	game_over.connect(Callable(get_parent().get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent().get_parent(), "on_game_cleared"))

func _input(event):
	if Input.is_key_pressed(KEY_RIGHT):
		posicion_jugador = 1
		$slidePlayer.play()
	elif Input.is_key_pressed(KEY_LEFT):
		posicion_jugador = 0
		$slidePlayer.play()
		
func _process(delta):
	if !win && !lose:
		if posicion_jugador == 1:
			if position.x < 170:
				position.x += 2000*delta
		elif posicion_jugador == 0:
			if position.x > -180:
				position.x += -2000*delta
				
	elif win == true:
		position.y = position.y + (-750*delta)
		
	elif lose == true:
		if posicion_jugador == 0:
			if tamaño:
				$playerSprite.scale += Vector2(10*delta, 10*delta)
				rotation += 25*delta
				if $playerSprite.scale > Vector2(5, 5):
					tamaño = false
			else:
				$playerSprite.scale += Vector2(-10*delta, -10*delta)
				rotation += -25*delta
			position.x += 750*delta
			if $playerSprite.scale < Vector2.ZERO:
				queue_free()
		elif posicion_jugador == 1:
			if tamaño:
				$playerSprite.scale += Vector2(10*delta, 10*delta)
				rotation += -25*delta
				if $playerSprite.scale > Vector2(5, 5):
					tamaño = false
			else:
				$playerSprite.scale += Vector2(-10*delta, -10*delta)
				rotation += 25*delta
			position.x += -700*delta
			if $playerSprite.scale < Vector2.ZERO:
				queue_free()

func _on_car_body_entered(body):
	if not lose:
		lose = true
		emit_signal("game_over")

func _on_right_pressed():
	posicion_jugador = 1
	$slidePlayer.play()

func _on_left_pressed():
	posicion_jugador = 0
	$slidePlayer.play()

func _on_area_2d_body_entered(body):
	win = true
	emit_signal("game_cleared")