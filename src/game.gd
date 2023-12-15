extends Node2D

# IMPORTANT: See README
# For developing, set "launch_minigame_directly" to the name of your
# corresponding minigame subfolder, and then start the project normally using F5
#var launch_minigame_directly = "esquivar.coches"
var launch_minigame_directly = "frutas"

signal game_timeout

# Array with the name of the minigames that will be played
var minigames = ["frutas", "esquivar.coches"]
var current_game_number = 0
var current_game_seconds_left = 0

func _ready():
	load_game(0)
	
func load_game(game_n):
	var scene
	if launch_minigame_directly != null:
		scene = load("res://minigames/" + launch_minigame_directly + "/main.tscn").instantiate()
	else:
		scene = load("res://minigames/" + minigames[game_n] + "/main.tscn").instantiate()
	scene.add_to_group("current_game")

	$HUD/Label.set_text(scene.info)
	if scene.needs_timer == true:
		game_timeout.connect(Callable(scene, "on_game_timeout"))
		current_game_seconds_left = scene.timer_seconds
		$Timer.start()

	add_child(scene)

func on_game_cleared():
	$Timer.stop()
	$HUD/Label.set_text("Game cleared!")
	await get_tree().create_timer(2).timeout
	
	if launch_minigame_directly == null:
		if current_game_number < minigames.size() - 1:
			current_game_number += 1
			for obj in get_children():
				if obj.is_in_group("current_game"):
					remove_child(obj)
					obj.remove_from_group("current_game")
					obj.queue_free()
					
			load_game(current_game_number)
		else:
			on_all_games_cleared()
	else:
		get_tree().change_scene_to_file("res://menu.tscn")

func on_all_games_cleared():
	$HUD/Label.set_text("All cleared!")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://menu.tscn")

func on_game_over():
	$Timer.stop()
	$HUD/Label.set_text("Game over!")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_timer_timeout():
	current_game_seconds_left -= 1
	$HUD/Label.set_text(str(current_game_seconds_left))
	if current_game_seconds_left <= 0:
		$Timer.stop()
		emit_signal("game_timeout")
		on_game_cleared()
