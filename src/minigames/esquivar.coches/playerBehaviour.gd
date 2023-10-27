extends CharacterBody2D

var posicion_jugador = 0

func _ready():
	position = Vector2(-190, 417)

func _input(event):
	if Input.is_key_pressed(KEY_RIGHT):
		posicion_jugador = 1
	elif Input.is_key_pressed(KEY_LEFT):
		posicion_jugador = 0
		
func _process(delta):
	if posicion_jugador == 1:
		if position.x < 170:
			position.x += 2000*delta
			
	elif posicion_jugador == 0:
		if position.x > -180:
			position.x += -2000*delta
	


func _on_car_body_entered(body):
	print("aAAAAAAAAAAAAAAA")


func _on_car_2_body_entered(body):
	print("aAAAAAAAAAAAAAAA")


func _on_car_3_body_entered(body):
	print("aAAAAAAAAAAAAAAA")


func _on_right_button_down():
	posicion_jugador = 1


func _on_left_button_down():
	posicion_jugador = 0
