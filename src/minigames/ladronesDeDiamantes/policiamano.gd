extends Sprite3D

# y = A * sin (kx - wt + f_0)

const amplificadorOnda = 10

func _process(delta):
	position.y = 7 + (sin(-PI*$timer.time_left) * delta * amplificadorOnda)


func _on_timer_timeout():
	$timer.start()
