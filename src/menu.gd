extends Node2D
signal play_button_pressed
signal game_picker_pressed
var game

func _ready():
	game = get_parent()
	play_button_pressed.connect(Callable(game, "on_play_button_pressed"))
	game_picker_pressed.connect(Callable(game, "on_game_picker_pressed"))

	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 1))	# Establecemos la dirección de la gravedad hacia abajo (lo normal)
	$DissolveRect.get_node("AnimationPlayer").play("fade_in")
	$Title.get_node("AnimatedSprite2D").play("default")
	$PlayButton.get_node("AnimatedSprite2D").play("default")

	for item in game.minigames:
		$GamePicker.add_item(item)

func _on_play_button_pressed():
	play_button_pressed.emit()

func _on_picker_toggle_pressed():
	$GamePicker.show()
	$PickerToggle.hide()

func _on_game_picker_item_clicked(index, at_position, mouse_button_index):
	game.launch_minigame_directly = game.minigames[index]
	play_button_pressed.emit()
