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
	get_child(1).play()
	if (!array.is_empty()):
		if (array[0].get_child(0, 0).get_color() == colorBoton):
			get_child(0).play()
			array[0].queue_free()
			array.remove_at(0)
			bajarBloques()

func bajarBloques():
	var tween = get_tree().create_tween()
	
	for i in array:
		tween.tween_property(i, "position", Vector2(0, i.position.y + 205), 0.01)
