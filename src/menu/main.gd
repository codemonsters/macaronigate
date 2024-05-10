# Credits:
# * Background image found here: https://www.pexels.com/photo/narrow-alley-in-town-in-italy-19560864/

extends Node2D

var game

@export var pasta_max = 150	# maximum number of pasta instances to create
@export var factor_gravedad = 1

var conchiglie_factory = preload("res://menu/pasta/conchiglie.tscn")
var farfale_factory = preload("res://menu/pasta/farfalle.tscn")
var fusilli_factory = preload("res://menu/pasta/fusilli.tscn")
var lumaconi_factory = preload("res://menu/pasta/lumaconi.tscn")
var macaroni_factory = preload("res://menu/pasta/macaroni.tscn")
var penne_factory = preload("res://menu/pasta/penne.tscn")
var pasta_num = 0	# number of pasta bodies instanciated
var start_button_enabled	# flag to enable / disable the action 
var angulo = 0
var direction = Vector2(0,1)

func _ready():
	# $GamePicker.get_v_scroll_bar().custom_minimum_size.x = 16
	# $GamePicker.get_v_scroll_bar().offset_right = 8
	if get_parent().get_name() == "game":
		game = get_parent()
		for item in game.minigames:
			$GamePicker.add_item(item)
		if game.launch_minigame_directly != null:
			$PickerToggle.set_text("Selected: " + game.launch_minigame_directly)
			$GamePicker.show()
	else:
		game = null
	
	pasta_num = 0
	_on_pasta_constructor_timer_timeout()	# creates the first pasta without waiting for the timer to end
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 1))	# Establecemos la dirección de la gravedad hacia abajo (lo normal)
	$PlayButton/AnimatableBody2D/AnimatedSprite2D.play("default")
	
	
func _on_pasta_constructor_timer_timeout():
	if pasta_num >= pasta_max:
		$PastaConstructorTimer.stop()
		return

	var pasta
	var i = randi_range(0, 5)
	match i:
		0:
			pasta = conchiglie_factory.instantiate()
		1:
			pasta = farfale_factory.instantiate()
		2:
			pasta = fusilli_factory.instantiate()
		3:
			pasta = lumaconi_factory.instantiate()
		4:
			pasta = macaroni_factory.instantiate()
		5:
			pasta = penne_factory.instantiate()
			
	pasta.position.x = randi_range(0, 720)
	pasta.rotation = randf_range(0, 2 * PI)
	pasta.angular_velocity = randf_range(-10, 10)
	$PastaContainer.add_child(pasta)
	pasta_num += 1


func _process(delta):
	angulo += Input.get_gyroscope().y*delta
	direction = factor_gravedad * Vector2(sin(angulo),cos(angulo))
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, direction)


func _on_play_button_pressed():
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0,1))
	assert(game != null, "You must run the game (and not directly this scene) to start a match")
	game.on_play_button_pressed()
	
	
func _on_picker_toggle_pressed():
	if $GamePicker.is_visible():
		$GamePicker.hide()
		$GamePicker.deselect_all();
		game.launch_minigame_directly = null
		$PickerToggle.set_text("Pick Game")
	else:
		$GamePicker.show()


func _on_game_picker_item_selected(index):
	game.launch_minigame_directly = game.minigames[index]
	$PickerToggle.set_text("Selected: " + game.minigames[index])

