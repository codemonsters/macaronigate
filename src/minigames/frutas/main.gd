extends Node2D

# Juan https://ninjikin.itch.io/fruit

@export var fruta_scene: PackedScene

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
	
	var velocity_x = (720 / 2 - fruta_spawn_location.position.x) * 1.5
	var velocity_y = randf_range(500, 800)
	fruta.linear_velocity = Vector2(velocity_x, velocity_y)
	
	add_child(fruta)
	# print("fruta")

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.is_pressed():
#			if event.position 
#			print("Object clicked")
	
