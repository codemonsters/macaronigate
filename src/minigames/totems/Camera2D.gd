extends Camera2D

var shaking = false
const amplitud = 10
const factor_velocidad_angular = 1000

func _on_stun_start():
	$shakeTimer.start()
	shaking = true

func _process(delta):
	if shaking:
		position.x = amplitud * sin(-PI*($shakeTimer.wait_time - $shakeTimer.time_left) * delta * factor_velocidad_angular )

func _on_shake_timer_timeout():
	shaking = false
	position.x = 0
	
