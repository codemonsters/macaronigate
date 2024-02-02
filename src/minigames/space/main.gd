extends Node2D
var instances = 0
var meteor_scene = load("res://minigames/space/meteor.tscn")
signal game_over
signal game_cleared

@export var game_brief = "Destroy!"
@export var needs_timer = true # False if your game doesn't need a countdown timer
@export var timer_seconds = 10 # Only set if needs_timer = true

# Called when the node enters the scene tree for the first time.
func _ready():
	game_over.connect(Callable(get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent(), "on_game_cleared"))

func _on_timer_timeout():
	if instances > 4:
		emit_signal("game_over")
	else:
		var meteor = meteor_scene.instantiate()
		instances += 1
		var size_vector2D = $Area2D/CollisionShape2D.shape.extents
		var origin = $Area2D/CollisionShape2D.global_position
		#meteor.position.x = randf_range(origin.x - 300, meteor_spawn_location.x)
		meteor.position.x = randf_range(origin[0] - size_vector2D[0], origin[0] + size_vector2D[0])
		meteor.position.y = randf_range(origin[1] - size_vector2D[1], origin[1] + size_vector2D[1])
		#meteor.position.y = randf_range(origin.y, meteor_spawn_location.y)

		add_child(meteor)
		meteor.add_to_group("needDelete")
	
func on_meteor_pressed(node):
	instances -= 1
	remove_child(node)
	node.queue_free()
	
func on_game_timeout():
	game_cleared.emit()
	$Timer.stop()
