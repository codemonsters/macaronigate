extends CharacterBody2D

var posicion_jugador = 0

var win = false

var lose = false

var tamaño = true

func _ready():
	position = Vector2(-190, 417)

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
	lose = true


func _on_car_2_body_entered(body):
	lose = true


func _on_car_3_body_entered(body):
	lose = true



func _on_right_button_down():
	posicion_jugador = 1
	$slidePlayer.play()


func _on_left_button_down():
	posicion_jugador = 0
	$slidePlayer.play()


func _on_area_2d_body_entered(body):
	win = true
