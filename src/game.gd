extends Node2D

var minigames = ["frutas", "happyhippo"]

func _ready():
	instance_scene(minigames[0])	
	

func _process(delta):
	pass
	
func instance_scene(scene_name):
	var scene = load("res://minigames/" + scene_name + "/main.tscn").instantiate()
#	var instance = scene.instantiate()
	add_child(scene)
