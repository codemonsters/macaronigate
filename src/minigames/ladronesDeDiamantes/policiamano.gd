extends Sprite3D

# y = A * sin (kx - wt + f_0)

const amplificadorOnda = 10

func _process(delta):
	position.y = 8.3 + (sin(-PI*$timer.time_left) * delta * amplificadorOnda)
	print(sin(-PI*$timer.time_left))


func _on_timer_timeout():
	$timer.start()
