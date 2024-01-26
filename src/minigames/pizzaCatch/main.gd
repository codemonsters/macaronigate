extends Node2D
var laura_scene = load("res://minigames/pizzaCatch/Laura.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _on_timer_timeout():
	var laura = laura_scene.instantiate()
	var laura_spawn_location = get_node("SpawnPath/SpawnLocation")
	laura_spawn_location.progress_ratio = randf()
	laura.position = laura_spawn_location.position
	
	add_child(laura)
