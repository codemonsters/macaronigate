extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
const GRAVITY = 1000.0
var movement = false
var volando = false
var alive = true
var main

func _ready():
	anim.play("reposo")
	main = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if main.in_game:
		if movement == true && alive == true:
			velocity.y = 0
			velocity.y -= 30000*delta
			anim.play("flying")
			volando = true
			movement = false
			
		if volando == true && anim.frame == 1 && alive == true:
			anim.play("reposo")
			volando = false
		
		velocity.y += GRAVITY*delta
		var motion = velocity * delta
		move_and_collide(motion)

func _on_button_pressed():
	if main.in_game:
		movement = true
		$aleteo_pajaro.play()

func die():
	if alive:
		alive = false
		anim.play("dead")
		rotate(PI)
		velocity.y -= 500
		if main.in_game:
			$falling.play()
