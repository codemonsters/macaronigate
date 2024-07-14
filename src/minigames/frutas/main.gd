extends Node2D
signal game_over
signal game_cleared

# Juan https://ninjikin.itch.io/fruit
#Sonido al cortar frutas: https://pixabay.com/sound-effects/search/sword/
#Sonido al ganar en frutas: https://www.storyblocks.com/audio/stock/japanese-bonsai-garden-koto-348755635.html?preview=1

@export var fruta_scene: PackedScene
var fruta_num = 0
var in_game = false

# Required variables
@export var game_brief = "Cut the fruit!"
@export var needs_timer = true
@export var timer_seconds = 5
@export var instructions_type = "swipe"

func _ready():
	game_over.connect(Callable(get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent(), "on_game_cleared"))
	
func on_game_start():
	in_game = true
	$FrutaTimer.start()

func _on_fruta_timer_timeout():
	var fruta = fruta_scene.instantiate()
	var fruta_spawn_location = get_node("SpawnPath/SpawnLocation")
	fruta_spawn_location.progress_ratio = randf()
	
	fruta.position = fruta_spawn_location.position
	fruta.rotation = randf_range(-PI / 4, PI / 4)
	fruta.angular_velocity = randf_range(-50, 50)
	
	var velocity_x = (720.0 / 2 - fruta_spawn_location.position.x) * randf_range(0.7, 1.8)
	var velocity_y = randf_range(500, 800)
	fruta.linear_velocity = Vector2(velocity_x, velocity_y)
	
	add_child(fruta)
	fruta.add_to_group("needDelete")

func _on_killbox_body_entered(body):
	if body.get_node("AnimatedSprite2D").get_frame() == 0 and in_game == true:
		$FrutaTimer.stop()
		in_game = false
		game_over.emit()

func on_game_timeout():
	$FrutaTimer.stop()
	in_game = false
	game_cleared.emit()
	
