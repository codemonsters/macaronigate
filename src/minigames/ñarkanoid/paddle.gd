extends Area2D


const MOVE_SPEED = 100
var velocity = 100
var movement = Vector2()
@export var speed = 3

var _ball_dir
var _left
var _right

@onready var _screen_size_x = get_viewport_rect().size.x


func _ready():
	var n = String(name).to_lower()
	_left = n + "_move_left"
	_right = n + "_move_right"
	if n == "left":
		_ball_dir = 1
	else:
		_ball_dir = -1


func _process(delta):
#	_on_CollidingArea_body_entered(Ball)
	# Move up and down based on input.
	#var input = Input.get_action_strength(_right) - Input.get_action_strength(_left)
	#position.x = clamp(position.y + input * MOVE_SPEED * delta, 16, _screen_size_x - 16)

	get_input()
	
	position.x = position.x + velocity.x
	position.y = position.y

func _on_area_entered(area):
	print("estoy aqui")
	if area.name == "Ball":
		# Assign new direction.
		area.direction = Vector2(_ball_dir, randf() * 2 - 1).normalized()
	
		
func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	
#func _on_CollidingArea_body_entered(body):
	# Check if the colliding body is an Area2D
#	if body is Area2D:
		# You can implement additional logic here if neede
