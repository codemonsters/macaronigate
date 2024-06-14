extends Node2D

signal instructions_finished
var positions : Array[Vector2]
var instances : Array[Node2D]

func _ready():
	var tap_scene = load("res://minigames_instructions/tap/tap.tscn")
	# print(positions)
	
	for p in positions:
		var instance = tap_scene.instantiate()
		instance.position = p
		add_child(instance)
		instances.append(instance)

		print("Instanced scene at position: ", p)

	for instance in instances:
		instance.get_node("AnimationPlayer").play("main")
		await get_tree().create_timer(0.5).timeout 

	await get_tree().create_timer(0.5).timeout
	instructions_finished.emit()
