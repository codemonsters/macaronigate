# Credits:
# * Background image found here: https://www.pexels.com/photo/narrow-alley-in-town-in-italy-19560864/

extends Node2D

var game
var play_pressed
signal play_button_pressed

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
	play_pressed = false;
	play_button_pressed.connect(Callable(get_parent(), "on_play_button_pressed"))
	# $GamePicker.get_v_scroll_bar().custom_minimum_size.x = 16
	# $GamePicker.get_v_scroll_bar().offset_right = 8
	if get_parent().get_name() == "game":
		game = get_parent()
		for item in game.minigames:
			$GamePicker.add_item(item)

		if game.launch_minigame_directly != null:
			var arrpos = game.minigames.find(game.launch_minigame_directly)
			$GamePicker.select(arrpos)
			$GamePicker.ensure_current_is_visible()
			_on_game_picker_item_selected(arrpos)
			$GamePicker.show()
			$UpButton.show()
			$DownButton.show()
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
	if Input.get_gyroscope().y > 0 and Input.get_gyroscope().z < 0:
		angulo += max(Input.get_gyroscope().y,-Input.get_gyroscope().z)*delta
	elif Input.get_gyroscope().y < 0 and Input.get_gyroscope().z > 0:
		angulo += min(Input.get_gyroscope().y,-Input.get_gyroscope().z)*delta
	direction = factor_gravedad * Vector2(sin(angulo),cos(angulo))
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, direction)


func _on_play_button_pressed():
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0,1))
	assert(game != null, "You must run the game (and not directly this scene) to start a match")
	if play_pressed == false:
		play_pressed = true
		play_button_pressed.emit()
	
	
func _on_picker_toggle_pressed():
	if $GamePicker.is_visible():
		$UpButton.hide()
		$DownButton.hide()
		$GamePicker.hide()
		$GamePicker.deselect_all();
		game.launch_minigame_directly = null
		$PickerToggle.set_text("Pick Game")
	else:
		$GamePicker.select(0)
		$GamePicker.ensure_current_is_visible()
		_on_game_picker_item_selected(0)
		$GamePicker.show()
		$UpButton.show()
		$DownButton.show()


func _on_game_picker_item_selected(index):
	game.launch_minigame_directly = game.minigames[index]
	$PickerToggle.set_text("Selected: " + game.minigames[index])

func _on_up_button_pressed():
	var selected = $GamePicker.get_selected_items()[0]
	var to_select
	if selected == 0:
		to_select = $GamePicker.get_item_count() - 1
	else:
		to_select = selected - 1
	$GamePicker.select(to_select)
	$GamePicker.ensure_current_is_visible()
	_on_game_picker_item_selected(to_select)

func _on_down_button_pressed():
	var selected = $GamePicker.get_selected_items()[0]
	var to_select
	if selected == $GamePicker.get_item_count() - 1:
		to_select = 0
	else:
		to_select = selected + 1
	$GamePicker.select(to_select)
	$GamePicker.ensure_current_is_visible()
	_on_game_picker_item_selected(to_select)
