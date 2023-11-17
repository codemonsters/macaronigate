extends SpotLight3D

var start = false
var light_on = true
var game_ended = false

signal game_win
signal game_lose

func _ready():
	light_energy = 16


func _on_timer_timeout():
	if (!start):
		$TimerStartEnd.wait_time = RandomNumberGenerator.new().randf_range(3, 5)
		start = true
		$TimerStartEnd.start()
	else:
		light_on = false
		light_energy = 0


func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if !game_ended and start:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if light_on:
					game_ended = true
					$TimerStartEnd.stop()
					game_lose.emit()
				else:
					game_win.emit()
