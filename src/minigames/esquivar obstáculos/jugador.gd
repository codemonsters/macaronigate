extends CharacterBody2D

var t = 0
var vx = 70
var vy = -310
var a = 275

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	pass
	
func jump(delta, direction):
	t += delta
	velocity.x = vx*direction
	velocity.y = vy + a*t
	move_and_slide()
