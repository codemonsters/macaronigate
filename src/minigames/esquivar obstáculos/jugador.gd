extends CharacterBody2D

var t = 0
var vx = 70
var vy_up = -310
var vy_down = -125
var a = 275

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	pass
	
func jump(delta, direction):
	if direction.y == 1:
		jump_up(delta, direction)
	else:
		jump_down(delta, direction)
	
func jump_up(delta, direction):
	t += delta
	velocity.x = vx*direction.x
	velocity.y = vy_up + a*t
	move_and_slide()

func jump_down(delta, direction):
	t += delta
	velocity.x = vx*direction.x
	velocity.y = vy_down + a*t
	move_and_slide()
