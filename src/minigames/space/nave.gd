extends Node2D
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#var velocity = Vector2.ZERO # The player's movement vector.
	#if Input.is_action_pressed("move_right"):
			#velocity.x += 1
	#if Input.is_action_pressed("move_left"):
			#velocity.x -= 1
#
	#if velocity.length() > 0:
		#velocity = velocity.normalized() * 400
		#
	#position += velocity * delta
	#position = position.clamp(Vector2(50, 0), Vector2(670, 1280))
