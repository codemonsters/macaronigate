extends CharacterBody2D

func _ready():
	position = Vector2(-190, 417)

func _input(event):
	if Input.is_key_pressed(KEY_RIGHT):
		position.x = 190
	elif Input.is_key_pressed(KEY_LEFT):
		position.x = -190


func _on_car_body_entered(body):
	print("aAAAAAAAAAAAAAAA")


func _on_car_2_body_entered(body):
	print("aAAAAAAAAAAAAAAA")


func _on_car_3_body_entered(body):
	print("aAAAAAAAAAAAAAAA")


func _on_right_button_down():
	position.x = 190


func _on_left_button_down():
	position.x = -190
