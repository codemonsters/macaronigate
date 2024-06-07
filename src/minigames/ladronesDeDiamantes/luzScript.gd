extends SpotLight3D

var start = false
var light_on = true
var game_ended = false
var flickering = false
var progress = 100
var stealing = false

var max_dark_time = 2

const progress_factor = 170
const losing_factor = 700

signal game_win
signal game_lose

func _ready():
	light_energy = 16


func _on_timer_timeout():
	if (!start):
		start = true


func _on_timer_flickers_timeout():
	if light_on:
		if flickering:
			$TimerFlickers.wait_time = RandomNumberGenerator.new().randf_range(0.5, 2) # Tiempo APAGADO
			light_energy = 0
		else:
			$TimerFlickers.wait_time = RandomNumberGenerator.new().randf_range(1, 2.5) # Tiempo ENCENDIDO
			light_energy = 16
		flickering = !flickering
		max_dark_time += 0.2
	else:
		$TimerFlickers.stop()


func _process(delta):
	if stealing:
		if light_energy == 0:
			progress += progress_factor * delta
		else:
			progress -= losing_factor * delta 
	if !game_ended:
		if progress >= 400:
			game_ended = true
			game_win.emit()
			stealing = false
		elif progress <= 0:
			game_ended = true
			game_lose.emit()
			stealing = false
	get_parent().get_child(1).size.x = progress # NO MOVER PROGRESSBAR
	


func _on_steal_button_down():
	if !game_ended:
		stealing = true


func _on_steal_button_up():
	stealing = false


# func _on_main_game_over():
# 	if !game_ended:
# 		game_lose.emit()
# 	game_ended = true
