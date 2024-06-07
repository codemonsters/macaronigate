extends Node2D

var block = preload("res://minigames/totems/Block.tscn")
var array = []
var stun = false
var game_in_progress = true
var main

signal stun_start
signal stun_end

signal end_game
signal win_game

func _ready():
	main = get_parent()
	for i in range(0, 32):
		array.append(block.instantiate())
		array [i].position.y = -205*i + 800
		array [i].position.x = 360
		
		add_child(array[i])



func _on_morado_boton_button_down():
	comprobarInput(0)


func _on_rosa_boton_button_down():
	comprobarInput(1)


func _on_naranja_boton_button_down():
	comprobarInput(2)


func comprobarInput(colorBoton):
	if (main.in_game == true):
		get_child(1).play()
		if (game_in_progress):
			if (len(array) > 1  and !stun):
				if (array[0].get_child(0, 0).get_color() == colorBoton):
					get_child(0).play()
					array[0].queue_free()
					array.remove_at(0)
					bajarBloques()
				else:
					$Timer.start()
					stun = true
					stun_start.emit()
			elif (len(array) == 1):
				get_child(0).play()
				array[0].queue_free()
				array.remove_at(0)
				win_game.emit()
				game_in_progress = false


func bajarBloques():
	for i in array:
		i.position = Vector2(360, i.position.y + 205)


func _on_timer_timeout():
	stun = false
	stun_end.emit()


func _on_game_timeout():
	if (game_in_progress):
		game_in_progress = false
