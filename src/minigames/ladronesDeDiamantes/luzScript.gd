extends SpotLight3D

var start = false
var light_on = true
var game_ended = false
var flickering = false
var flicker_time = 0.1

signal game_win
signal game_lose

func _ready():
	light_energy = 16


func _on_timer_timeout():
	if (!start):
		$TimerStartEnd.wait_time = RandomNumberGenerator.new().randf_range(2.5, 5)
		start = true
		$TimerStartEnd.start()
	else:
		light_on = false
		light_energy = 0


func _on_area_3d_input_event(_camera, event, _position, _normal, _shape_idx):
	if !game_ended and start:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if light_energy == 0:
					game_win.emit()
				else:
					game_ended = true
					$TimerStartEnd.stop()
					game_lose.emit()


func _on_timer_flickers_timeout():
	if light_on:
		if flickering:
			$TimerFlickers.wait_time = RandomNumberGenerator.new().randf_range(0.2, 0.4)
			light_energy = 0
		else:
			$TimerFlickers.wait_time = RandomNumberGenerator.new().randf_range(0.1, flicker_time)
			light_energy = 16
		flickering = !flickering
		flicker_time += 0.05
	else:
		$TimerFlickers.stop()
