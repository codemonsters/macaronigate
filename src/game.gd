extends Node2D

##### DEBUG OPTIONS START #####

# IMPORTANT: See README
# For developing, inside the menu click "Pick Game" and pick your game
# Alternatively, you can set "launch_minigame_directly" to the name of your
# corresponding minigame subfolder, and then start the project normally using F5
# var launch_minigame_directly = "esquivar.coches"
var launch_minigame_directly = null

# If you want to launch specific minigames in a specific order
# var minigames_order_override = ["ñarkanoid", "pizzaCatch"]
var minigames_order_override = null

# To limit the game length
var limit_minigames_count = 5

##### DEBUG OPTIONS END #####

signal game_timeout
signal game_start

# Array with the name of the minigames that will be played
var minigames = [
	"boton no", "boton si", "esquivar.coches", "explotar_globo",
	"flapuie biuegtwt", "frutas", "ladronesDeDiamantes",
	"ñarkanoid", "pizzaCatch", "space", "totems", "willinghippo",
	"cuchina disastrosa"
	#"panelDeBotones", "pulsar_mucho"
	]

var first_run_flag = true
var minigames_shuffled
var current_game_number
var current_game_seconds_left = 0
var signal_inhibit = false
var skip_enabled = false
var state
var elevator
var death_screen
var win_screen

func _ready():
	state = null
	if minigames_order_override == null:
		minigames_shuffled = minigames.duplicate()
		minigames_shuffled.shuffle()
		if limit_minigames_count != null && minigames_shuffled.size() > limit_minigames_count:
			minigames_shuffled.resize(limit_minigames_count)
	else:
		minigames_shuffled = minigames_order_override.duplicate()
	
	print("Shuffled order: " + str(minigames_shuffled))
	current_game_number = 0
	remove_children_in_group("current_game")
	$HUD/Label.hide()

	if first_run_flag:
		if launch_minigame_directly == null:
			load_intro_developer()
		else:
			load_game()
		first_run_flag = false
	else:
		load_menu()

func load_intro_developer():
	var intro_developer = load("res://intro_developer/main.tscn").instantiate()
	intro_developer.add_to_group("intro_developer")
	add_child(intro_developer)

func on_intro_developer_finished():
	$FadeRect.color = Color.BLACK
	remove_children_in_group("intro_developer")
	load_menu()

func load_menu():
	#print("Loading menu...")
	$AnimationPlayer.play("fade_out_black")
	var menu = load("res://menu/main.tscn").instantiate()
	menu.add_to_group("menu")
	add_child(menu)
	signal_inhibit = false

func load_game_intro():
	#print("Loading game intro...")
	var scene = load("res://intro_game/main.tscn").instantiate()
	add_child(scene)
	$AnimationPlayer.play("fade_out_black")
	
func load_game(game_n = 0):
	if launch_minigame_directly != null:
		print("Loading game directly... " + launch_minigame_directly)
	else:
		print("Loading game " + str(game_n + 1) + " of " + str(minigames_shuffled.size()) + "... " + minigames_shuffled[game_n])
		
	var scene
	if launch_minigame_directly != null:
		scene = load("res://minigames/" + launch_minigame_directly + "/main.tscn").instantiate()
	else:
		scene = load("res://minigames/" + minigames_shuffled[game_n] + "/main.tscn").instantiate()
	scene.add_to_group("current_game")

	$HUD/Label.set_text(scene.game_brief)
	$HUD/Label.show()
	
	$HUD/Label.scale = Vector2(1, 1)
	$HUD/Label.rotation = 0
	
	var tweenScale = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	var tweenRotation = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	
	for i in range(0, 2):
		tweenScale.tween_property($HUD/Label, "scale", Vector2(1.4, 1.4), 0.5)
		tweenRotation.tween_property($HUD/Label, "rotation", 0.10, 0.3)
		
		tweenScale.tween_property($HUD/Label, "scale", Vector2(1, 1), 0.5)
		tweenRotation.tween_property($HUD/Label, "rotation", -0.10, 0.3)
		
	tweenRotation.tween_property($HUD/Label, "rotation", 0, 0.3)
	
	game_start.connect(Callable(scene, "on_game_start"))
	if scene.needs_timer:
		game_timeout.connect(Callable(scene, "on_game_timeout"))
		current_game_seconds_left = scene.timer_seconds

	add_child(scene)
	if game_n == 0:
		$AnimationPlayer.play("fade_out_black")
	else:
		$AnimationPlayer.play("fade_out_white")
	await $AnimationPlayer.animation_finished
	
	if scene.get("instructions_type") != null:
		var instructions = load("res://minigames_instructions/" + scene.instructions_type + "/main.tscn").instantiate()
		instructions.add_to_group("game_instructions")

		if scene.get("instructions_tap_positions") != null:
			instructions.positions = scene.instructions_tap_positions
			add_child(instructions)
			await instructions.instructions_finished
		else:
			add_child(instructions)
			await instructions.get_node("AnimationPlayer").animation_finished

		remove_children_in_group("game_instructions")
	
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0,1))
	game_start.emit()
	signal_inhibit = false
	if scene.needs_timer: $Timer.start()
	state = "game"
	if skip_enabled == true:
		$HUD/SkipButton.show()

# Carga elevator.tscn, y esta despues llamará a load_game(). 
func enter_elevator():
	$HUD/Label.set_text("")
	elevator = load("res://elevator/main.tscn").instantiate()
	elevator.set_starting_floor_number(current_game_number - 1)
	add_child(elevator)
	state = "elevator"
	if skip_enabled == true:
		$HUD/SkipButton.show()

func on_elevator_exit():
	state = null
	$HUD/SkipButton.hide()
	$FadeRect.color = Color.WHITE
	elevator.queue_free()
	load_game(current_game_number)

func on_game_cleared():
	print("game_cleared signal received")
	if signal_inhibit == true:
		print("Signal inhibited!")
		#assert(false, "Signal inhibited! Make sure the game does not send signals after game ends!")
	else:
		signal_inhibit = true
		state = null
		$HUD/SkipButton.hide()
		$Timer.stop()
		$HUD/Label.set_text("Game cleared!")
		await get_tree().create_timer(1).timeout
		$AnimationPlayer.play("fade_in_black")
		await $AnimationPlayer.animation_finished
		
		if launch_minigame_directly == null:
			if current_game_number < minigames_shuffled.size() - 1:
				current_game_number += 1
				remove_children_in_group("current_game")
				enter_elevator() 
				#load_game(current_game_number)
			else:
				on_all_games_cleared()
		else:
			_ready()

func on_all_games_cleared():
	$HUD/Label.set_text("All cleared!")
	load_win_screen()

func load_win_screen():
	remove_children_in_group("current_game")
	win_screen = load("res://win_screen/main.tscn").instantiate()
	add_child(win_screen)
	$AnimationPlayer.play("fade_out_black")

func leave_win_screen():
	$AnimationPlayer.play("fade_in_black")
	await $AnimationPlayer.animation_finished
	win_screen.queue_free()
	_ready()

func on_game_over():
	print("game_over signal received")
	if signal_inhibit == true:
		print("Signal inhibited!")
		#assert(false, "Signal inhibited! Make sure the game does not send signals after game ends!")
	else:
		signal_inhibit = true
		state = null
		$HUD/SkipButton.hide()
		$Timer.stop()
		$HUD/Label.set_text("Game over!")
		if launch_minigame_directly == null:
			await get_tree().create_timer(2).timeout
			$AnimationPlayer.play("fade_in_black")
			await $AnimationPlayer.animation_finished
			load_death_screen()
		else:
			await get_tree().create_timer(1).timeout
			$AnimationPlayer.play("fade_in_black")
			await $AnimationPlayer.animation_finished
			_ready()

func load_death_screen():
	remove_children_in_group("current_game")
	death_screen = load("res://death_screen/main.tscn").instantiate()
	add_child(death_screen)
	$AnimationPlayer.play("fade_out_black")

func leave_death_screen():
	$AnimationPlayer.play("fade_in_black")
	await $AnimationPlayer.animation_finished
	death_screen.queue_free()
	_ready()

func _on_timer_timeout():
	current_game_seconds_left -= 1
	$HUD/Label.set_text(str(current_game_seconds_left))
	if current_game_seconds_left <= 0:
		$Timer.stop()
		emit_signal("game_timeout")

func on_game_intro_finished():
	$AnimationPlayer.play("fade_in_black")
	await $AnimationPlayer.animation_finished
	game_start.emit()
	$"IntroAnimation".queue_free()
	load_game()
	
func on_play_button_pressed():
	print("Play Button Pressed")
	$AnimationPlayer.play("fade_in_black")
	await $AnimationPlayer.animation_finished
	remove_children_in_group("menu")
	if launch_minigame_directly == null:
		load_game_intro()
	else:
		load_game()

## TODO: Investigar
# func on_play_button_pressed():
# 	if signal_inhibit == true:
# 		print("Play button signal inhibited!")
# 		#assert(false, "Signal inhibited! Make sure the game does not send signals after game ends!")
# 	else:
# 		signal_inhibit = true
# 		$AnimationPlayer.play("fade_in_black")
# 		await $AnimationPlayer.animation_finished
# 		remove_children_in_group("menu")
# 		if launch_minigame_directly == null:
# 			load_game_intro()
# 		else:
# 			load_game()

func remove_children_in_group(group):
	for obj in get_children():	
		if obj.is_in_group(group):
			destroy_children(obj)
			obj.queue_free()
	
func destroy_children(parent):
	for child in parent.get_children():
		if child.get_child_count() == 0:
			child.queue_free()
		else:
			destroy_children(child)

func _on_skip_button_pressed():
	if state == "game":
		on_game_cleared()
	elif state == "elevator":
		on_elevator_exit()
		# instructions.instructions_finished.emit()

	$HUD/SkipButton.hide()
	state = null
