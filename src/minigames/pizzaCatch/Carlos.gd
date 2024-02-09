extends Node2D
var left = 0
var right = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right") or right == 1:
			velocity.x += 1.3
	if Input.is_action_pressed("move_left") or left == 1:
			velocity.x -= 1.3

	if velocity.length() > 0:
		velocity = velocity.normalized() * 400
		
	position += velocity * delta
	position = position.clamp(Vector2(50, 0), Vector2(670, 1280))

func _on_left_button_up():
	left = 0

func _on_left_button_down():
	left = 1


func _on_right_button_down():
	right = 1


func _on_right_button_up():
	right = 0
