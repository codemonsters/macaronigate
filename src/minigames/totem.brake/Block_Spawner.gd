extends Node2D

var block = preload("res://minigames/totem.brake/Block.tscn")

var array = []

func _ready():
	
	for i in range(0, 8):
		array.append(block.instantiate())
		array [i].position.y = -205*i + 75
		
		add_child(array[i])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
