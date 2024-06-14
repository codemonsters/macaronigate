extends Node2D
signal game_over
signal game_cleared

# Flying Bird Character (for the credits) thanks to bevouliin.com (https://opengameart.org/content/bevouliin-free-flying-bird-game-character-sprite-sheets)
#Sonido aleteo: Flapping Wings de Mike Koening https://soundbible.com/627-Flapping-Wings.html

@export var game_brief = "Flappy bird"
@export var needs_timer = true
@export var timer_seconds = 10
@export var instructions_type = "tap"
var instructions_tap_positions : Array[Vector2] = [ Vector2(360, 640) ]

var pipe_scene = load("res://minigames/flapuie biuegtwt/pipe.tscn")
var randomGenerator = RandomNumberGenerator.new()
var win = false
var in_game = false

# Called when the node enters the scene tree for the first time.
func _ready():
	game_over.connect(Callable(get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent(), "on_game_cleared"))
	_on_new_pipes_timer_timeout()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if in_game:
		var pipes = $Pipes.get_children()
		for pipe in pipes:
			pipe.position.x -= 200 * delta
	
func on_game_start():
	in_game = true
	$Bird.freeze = false
	$NewPipesTimer.start()
	
func on_game_timeout():
	game_cleared.emit()
	win = true


func _on_new_pipes_timer_timeout():
	# highest lower pipe Y: 800, lowest lower pipe Y: 1680
	# highest upper pipe Y: -400, lowest lower pipe Y: 480
	
	var new_lower_pipe_instance = pipe_scene.instantiate()
	new_lower_pipe_instance.set_position(Vector2(720 + new_lower_pipe_instance.get_width() / 2, randomGenerator.randi_range(800, 1680)))
	$Pipes.add_child(new_lower_pipe_instance)
		
	var new_upper_pipe_instance = pipe_scene.instantiate()
	new_upper_pipe_instance.set_position(Vector2(720 + new_upper_pipe_instance.get_width() / 2, new_lower_pipe_instance.get_position().y - 1200))
	new_upper_pipe_instance.rotate(PI)
	$Pipes.add_child(new_upper_pipe_instance)
	


func _on_muerte_body_entered(body):
	if body.name == "Bird" && win != true:
		game_over.emit()
		
