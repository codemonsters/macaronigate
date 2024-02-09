extends RigidBody2D

@onready var anim = $AnimatedSprite2D
var movement = false
var volando = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if movement == true:
		linear_velocity.y = 0
		linear_velocity.y -= 30000*delta
		anim.play("flying")
		volando = true
		movement = false
		
	if volando == true && anim.frame == 1:
		anim.play("reposo")
		volando = false

func _on_button_pressed():
	
	movement = true
	
	
	
	



