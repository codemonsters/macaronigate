extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(_delta):
	if Input.is_action_pressed("jump"):
		apply_central_impulse(Vector2(0,10))
