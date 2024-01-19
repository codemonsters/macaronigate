extends Node2D

var meteor_scene = load("res://minigames/space/meteor.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_timer_timeout():
	var meteor = meteor_scene.instantiate()
	
	var size_vector2D = $Area2D/CollisionShape2D.shape.extents
	var origin = $Area2D/CollisionShape2D.global_position
	#meteor.position.x = randf_range(origin.x - 300, meteor_spawn_location.x)
	meteor.position.x = randf_range(origin[0] - size_vector2D[0], origin[0] + size_vector2D[0])
	meteor.position.y = randf_range(origin[1] - size_vector2D[1], origin[1] + size_vector2D[1])
	#meteor.position.y = randf_range(origin.y, meteor_spawn_location.y)

	add_child(meteor)
	meteor.add_to_group("needDelete")
