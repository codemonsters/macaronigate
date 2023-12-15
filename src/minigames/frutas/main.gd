extends Node2D
signal game_over

# Juan https://ninjikin.itch.io/fruit

@export var fruta_scene: PackedScene
var fruta_num = 0
var in_game

# Required variables
@export var info = "Cut the fruit!"
@export var needs_timer = true
@export var timer_seconds = 5

func _ready():
	game_over.connect(Callable(get_parent(), "on_game_over"))
	in_game = true

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

func _on_killbox_body_entered(body):
	if body.get_node("AnimatedSprite2D").get_frame() == 0 and in_game == true:
		on_game_timeout()
		emit_signal("game_over")

func on_game_timeout():
	$FrutaTimer.stop()
	in_game = false
