extends Node2D

# IMPORTANT: See README
# For developing, inside the menu click "Pick Game" and pick your game
# Alternatively, you can set "launch_minigame_directly" to the name of your
# corresponding minigame subfolder, and then start the project normally using F5
#var launch_minigame_directly = "esquivar.coches"
#var launch_minigame_directly = null
var launch_minigame_directly = null

signal game_timeout
signal game_start

# Array with the name of the minigames that will be played
var minigames = ["boton si", "boton no", "esquivar.coches", "frutas", "ñarkanoid", "pizzaCatch", "space", "totems", "willinghippo"]
var minigames_shuffled
var current_game_number
var current_game_seconds_left = 0
var signal_inhibit = false

func _ready():
	#$AnimationPlayer.play("fade_out_black")
	#await $AnimationPlayer.animation_finished
	minigames_shuffled = minigames.duplicate()
	minigames_shuffled.shuffle()
	print("Shuffled order: " + str(minigames_shuffled))
	current_game_number = 0
	remove_childs_in_group("current_game")
	load_menu()
	
func load_menu():
	#print("Loading menu...")
	$AnimationPlayer.play("fade_out_black")
	$HUD/Label.hide()
	var menu = load("res://menu.tscn").instantiate()
	menu.add_to_group("menu")
	add_child(menu)

func load_game_intro():
	#print("Loading game intro...")
	var scene = load("res://intro_game/main.tscn").instantiate()
	game_start.connect(Callable(scene, "on_game_start"))
	add_child(scene)
	$AnimationPlayer.play("fade_out_black")
	await $AnimationPlayer.animation_finished
	game_start.emit()
	
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
	if scene.needs_timer == true:
		game_timeout.connect(Callable(scene, "on_game_timeout"))
		current_game_seconds_left = scene.timer_seconds
		$Timer.start()

	add_child(scene)
	$AnimationPlayer.play("fade_out_black")
	await $AnimationPlayer.animation_finished
	game_start.emit()
	signal_inhibit = false

func on_game_cleared():
	print("game_cleared signal received")
	if signal_inhibit == true:
		print("Signal inhibited!")
		#assert(false, "Signal inhibited! Make sure the game does not send signals after game ends!")
	else:
		signal_inhibit = true
		$Timer.stop()
		$HUD/Label.set_text("Game cleared!")
		await get_tree().create_timer(2).timeout
		
		if launch_minigame_directly == null:
			if current_game_number < minigames_shuffled.size() - 1:
				current_game_number += 1
				remove_childs_in_group("current_game")
				load_game(current_game_number)
			else:
				on_all_games_cleared()
		else:
			_ready()

func on_all_games_cleared():
	$HUD/Label.set_text("All cleared!")
	await get_tree().create_timer(2).timeout
	_ready()

func on_game_over():
	print("game_over signal received")
	if signal_inhibit == true:
		print("Signal inhibited!")
		#assert(false, "Signal inhibited! Make sure the game does not send signals after game ends!")
	else:
		signal_inhibit = true
		$Timer.stop()
		$HUD/Label.set_text("Game over!")
		await get_tree().create_timer(2).timeout
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
	$AnimationPlayer.play("fade_in_black")
	await $AnimationPlayer.animation_finished
	#$ColorRect.hide()
	remove_childs_in_group("menu")
	if launch_minigame_directly == null:
		load_game_intro()
	else:
		load_game()

func remove_childs_in_group(group):
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
