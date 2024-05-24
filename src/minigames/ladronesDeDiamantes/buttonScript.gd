extends Button

var first_press = false

func _process(delta):
	if !first_press:
		position.y = 930 + (12*sin(4*PI * $timer.time_left))

func _on_button_down():
	if !first_press:
		first_press = true
		position.y = 930
	modulate = Color(0.6, 0.6, 0.6)


func _on_button_up():
	modulate = Color(1, 1, 1)
