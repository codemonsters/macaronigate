extends CharacterBody2D

var fall = false
var t = 0
var vx = 120
var vx_side = 300
var vy_up = -475
var vy_down = -150
var vy_side = -75
var a_up = 675
var a_down = 700
var a_side = 200

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if fall == true:
		velocity.y += 100*delta
		move_and_slide()
	
func jump(delta, direction):
	if direction.y == 1:
		jump_up(delta, direction)
	elif direction.y == -1:
		jump_down(delta, direction)
	else:
		jump_side(delta, direction)
	
func jump_up(delta, direction):
	t += delta
	velocity.x = vx*direction.x
	velocity.y = vy_up + a_up*t
	move_and_slide()

func jump_down(delta, direction):
	t += delta
	velocity.x = vx*direction.x
	velocity.y = vy_down + a_down*t
	move_and_slide()
	
func jump_side(delta, direction):
	t += delta
	velocity.x = vx_side*direction.x
	velocity.y = vy_side + a_side*t
	move_and_slide()

func die(delta):
	$CollisionShape2D.free()
	rotate(-1)
	fall = true
