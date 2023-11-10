extends Node2D

var block = preload("res://minigames/totem.break/Block.tscn")
var array = []

func _ready():
	
	for i in range(0, 20):
		array.append(block.instantiate())
		array [i].position.y = -205*i + 75
		
		add_child(array[i])


func _on_morado_boton_button_down():
	comprobarInput(0)


func _on_rosa_boton_button_down():
	comprobarInput(1)


func _on_naranja_boton_button_down():
	comprobarInput(2)


func comprobarInput(colorBoton):
	if (!array.is_empty()):
		if (array[0].get_child(0, 0).get_color() == colorBoton):
			array[0].queue_free()
			array.remove_at(0)
			bajarBloques()

func bajarBloques():
	for i in array:
		i.position.y += 205
