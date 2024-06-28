extends Camera3D

const ROTATION_SPEED = 1
const AMPLITUDE = 3

var spinning = false


func _process(delta):
	if spinning:
		rotation += Vector3(0, ROTATION_SPEED, 0) * delta
		
		position.x = AMPLITUDE * sin(rotation.y)
		position.z = AMPLITUDE * cos(rotation.y)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "walk_forward":
		spinning = true
