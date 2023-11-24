extends Node2D
signal game_over

# Juan https://ninjikin.itch.io/fruit

@export var fruta_scene: PackedScene
var fruta_num = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$FrutaTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_fruta_timer_timeout():
	var fruta = fruta_scene.instantiate()
	var fruta_spawn_location = get_node("SpawnPath/SpawnLocation")
	fruta_spawn_location.progress_ratio = randf()
	
	fruta.position = fruta_spawn_location.position
	fruta.rotation = randf_range(-PI / 4, PI / 4)
	fruta.angular_velocity = randf_range(-50, 50)
	
	var velocity_x = (720 / 2 - fruta_spawn_location.position.x) * randf_range(0.7, 1.8)
	var velocity_y = randf_range(500, 800)
	fruta.linear_velocity = Vector2(velocity_x, velocity_y)
	
	add_child(fruta)
	fruta.add_to_group("needDelete")
	# print("fruta")
	
#	fruta_num += 1
#	if (fruta_num >= 20):
#		$FrutaTimer.stop()

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.is_pressed():
#			if event.position 
#			print("Object clicked")
#func _physics_process(delta):
#	# get the Physics2DDirectSpaceState object
#	var space = get_world_2d().direct_space_state
#	# Get the mouse's position
#	var mousePos = get_viewport().get_mouse_position()
#	# Check if there is a collision at the mouse position
#	var query = PhysicsPointQueryParameters2D.new()
#	query.position = mousePos
#
#	if space.intersect_point(query, 1):
#		print("hit something")
#	else:
#		print("no hit")

# func _on_killbox_body_entered(body):
# 	game_over.emit()
# 	$FrutaTimer.stop()
	
# 	for obj in get_children():
# 		if obj.is_in_group("needDelete"):
# 			remove_child(obj)
# 			obj.remove_from_group("needDelete")
# 			obj.queue_free()

