extends Area2D


const DEFAULT_SPEED = 150

var _speed = DEFAULT_SPEED
var direction = Vector2.DOWN

@onready var _initial_pos = position

	
func _process(delta):
	_on_MovingArea_body_entered($"../paddle")
	_speed += delta * 2
	position += _speed * delta * direction
	

func reset():
	direction = Vector2.DOWN
	position = _initial_pos
	_speed = DEFAULT_SPEED
	
func _on_MovingArea_body_entered(body):
	# Check if the colliding body is an Area2D
	if body is Area2D:
		# Change the movement direction when collision occurs
		direction = -direction

