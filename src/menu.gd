extends Node2D
signal play_button_pressed
signal game_picker_pressed
var game

func _ready():
	game = get_parent()
	#play_button_pressed.connect(Callable(game, "on_play_button_pressed"))
	#game_picker_pressed.connect(Callable(game, "on_game_picker_pressed"))

	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 1))	# Establecemos la dirección de la gravedad hacia abajo (lo normal)
	$DissolveRect.get_node("AnimationPlayer").play("fade_in")
	$Title.get_node("AnimatedSprite2D").play("default")
	$PlayButton.get_node("AnimatedSprite2D").play("default")

	# print(game.launch_minigame_directly)
	for item in game.minigames:
		$GamePicker.add_item(item)
	if game.launch_minigame_directly != null:
		$PickerToggle.set_text("Selected: " + game.launch_minigame_directly)
		$GamePicker.show()

func _on_play_button_pressed():
	game.on_play_button_pressed()

func _on_picker_toggle_pressed():
	if $GamePicker.is_visible():
		$GamePicker.hide()
		# print(game.launch_minigame_directly)
		# print(game.minigames)
		game.launch_minigame_directly = null
		$PickerToggle.set_text("Pick Game")
	else:
		# $GamePicker.clear()
		# for item in game.minigames:
		# 	$GamePicker.add_item(item)
		$GamePicker.show()

# func _on_game_picker_item_clicked(index, at_position, mouse_button_index):
# 	game.launch_minigame_directly = game.minigames[index]
# 	play_button_pressed.emit()

func _on_game_picker_item_selected(index):
	game.launch_minigame_directly = game.minigames[index]
	$PickerToggle.set_text("Selected: " + game.minigames[index])
