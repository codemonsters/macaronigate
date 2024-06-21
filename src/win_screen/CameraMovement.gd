extends Camera3D

const ROTATION_SPEED = 1
const AMPLITUDE = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += Vector3(0, ROTATION_SPEED, 0) * delta
	
	position.x = AMPLITUDE * sin(rotation.y)
	position.z = AMPLITUDE * cos(rotation.y)
