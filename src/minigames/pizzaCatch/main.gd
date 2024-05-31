extends Node2D
var laura_scene = load("res://minigames/pizzaCatch/Laura.tscn")
signal game_over
signal game_cleared
var in_game = true

@export var game_brief = "Catch the pizza!"
@export var needs_timer = true # False if your game doesn't need a countdown timer
@export var timer_seconds = 10 # Only set if needs_timer = true
@export var instruction_type = "touch_left_or_right"

# Called when the node enters the scene tree for the first time.
func _ready():
	game_over.connect(Callable(get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent(), "on_game_cleared"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_game_start():
	$Timer.start()

func _on_timer_timeout():
	var laura = laura_scene.instantiate()
	var laura_spawn_location = get_node("SpawnPath/SpawnLocation")
	laura_spawn_location.progress_ratio = randf()
	laura.position = laura_spawn_location.position
	
	add_child(laura)
	
func on_pizza_catched(node):
	node.queue_free()

func _on_area_2d_body_entered(body):
	if in_game == true:
		emit_signal("game_over")
		$Timer.stop()
		$Carlos/StaticBody2D/Cesta2.show()
		$Carlos/StaticBody2D/Cesta1.hide()
	
func on_game_timeout():
	emit_signal("game_cleared")
	$Timer.stop()
	in_game = false
