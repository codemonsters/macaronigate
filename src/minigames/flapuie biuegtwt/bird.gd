extends RigidBody2D

var movement = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if movement == true:
		linear_velocity.y = 0
		linear_velocity.y -= 30000*delta
		movement = false

func _on_button_pressed():
	
	movement = true
	
	
	
	



