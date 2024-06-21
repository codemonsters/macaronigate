extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
const GRAVITY = 1000.0
var movement = false
var volando = false
# var main
# # Called when the node enters the scene tree for the first time.
# func _ready():
# 	main = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if movement == true:
		velocity.y = 0
		velocity.y -= 30000*delta
		anim.play("flying")
		volando = true
		movement = false
		
	if volando == true && anim.frame == 1:
		anim.play("reposo")
		volando = false
	
	velocity.y += GRAVITY*delta
	var motion = velocity * delta
	move_and_collide(motion)

func _on_button_pressed():
	movement = true
	$aleteo_pajaro.play()
