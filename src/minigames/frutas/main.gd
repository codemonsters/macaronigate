extends Node2D
signal game_over
signal game_cleared

# Juan https://ninjikin.itch.io/fruit

@export var fruta_scene: PackedScene
var fruta_num = 0
@export var info = "Cut the fruit!"
@export var needs_timer = true
# @export var timer_steps = 1
@export var timer_seconds = 5
var hud
var in_game


func _ready():
	# hud = get_node("../HUD/Label")
	# hud.set_text("Cut the fruit!")
	# hud.show()
	game_over.connect(Callable(get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent(), "on_game_cleared"))
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
		stop_game()
		emit_signal("game_over")

# func _on_game_timer_timeout():
# 	game_seconds -= 1
# 	hud.set_text(str(game_seconds))
# 	if game_seconds <= 0:
# 		stop_game()
# 		emit_signal("game_cleared")
#		game_over_func()

#func game_over_func():
#	hud.set_text("Cut the fruit!")
#	for obj in get_children():
#		if obj.is_in_group("needDelete"):
#			remove_child(obj)
#			obj.remove_from_group("needDelete")
#			obj.queue_free()
#	await get_tree().create_timer(1).timeout
#	game_seconds = 9
#	$FrutaTimer.start()
#	$GameTimer.start()
	
func stop_game():
	$FrutaTimer.stop()
	$GameTimer.stop()
	in_game = false

func on_game_timeout():
	print("Timeout!")
	stop_game()
	# emit_signal("game_cleared")
