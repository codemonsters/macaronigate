extends Node2D

# IMPORTANT: See README
# For developing, inside the menu click "Pick Game" and pick your game
# Alternatively, you can set "launch_minigame_directly" to the name of your
# corresponding minigame subfolder, and then start the project normally using F5
# var launch_minigame_directly = "esquivar.coches"
var launch_minigame_directly = null
# If you want to launch specific minigames in a specific order
# var minigames_order_override = ["ñarkanoid", "pizzaCatch"]
var minigames_order_override = null

signal game_timeout
signal game_start

# Array with the name of the minigames that will be played
var minigames = [
	"boton no", "boton si", "esquivar.coches", "explotar_globo",
	"flapuie biuegtwt", "frutas", "ladronesDeDiamantes",
	"ñarkanoid", "pizzaCatch", "space", "totems", "willinghippo",
	#"panelDeBotones", "pulsar_mucho"
	]

var minigames_shuffled
var current_game_number
var current_game_seconds_left = 0
var signal_inhibit = false

func _ready():
	#$AnimationPlayer.play("fade_out_black")
	#await $AnimationPlayer.animation_finished
	if minigames_order_override == null:
		minigames_shuffled = minigames.duplicate()
		minigames_shuffled.shuffle()
	else:
		minigames_shuffled = minigames_order_override.duplicate()
	
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
	
	game_start.connect(Callable(scene, "on_game_start"))
	if scene.needs_timer:
		# game_start.connect(Callable(scene, "on_game_start"))
		game_timeout.connect(Callable(scene, "on_game_timeout"))
		current_game_seconds_left = scene.timer_seconds

	add_child(scene)
	$AnimationPlayer.play("fade_out_black")
	await $AnimationPlayer.animation_finished
	
	if scene.get("instruction_type") != null:
		var instructions = load("res://minigames_instructions/" + scene.instruction_type + "/main.tscn").instantiate()
		instructions.add_to_group("game_instructions")
		add_child(instructions)
		#print(get_node("Main/AnimationPlayer"))
		#get_tree.get_nodes_in_group("game_instructions")
		#for index in range(get_child_count()):
			#print(get_child(index).get_groups())
		
		await instructions.get_node("AnimationPlayer").animation_finished
		remove_childs_in_group("game_instructions")
	
	game_start.emit()
	signal_inhibit = false
	if scene.needs_timer: $Timer.start()

func on_game_cleared():
	print("game_cleared signal received")
	if signal_inhibit == true:
		print("Signal inhibited!")
		#assert(false, "Signal inhibited! Make sure the game does not send signals after game ends!")
	else:
		signal_inhibit = true
		$Timer.stop()
		$HUD/Label.set_text("Game cleared!")
		await get_tree().create_timer(1).timeout
		$AnimationPlayer.play("fade_in_black")
		await $AnimationPlayer.animation_finished
		
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
		$AnimationPlayer.play("fade_in_black")
		await $AnimationPlayer.animation_finished
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
