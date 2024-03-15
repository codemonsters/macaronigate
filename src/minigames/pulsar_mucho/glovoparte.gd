extends RigidBody2D
var cliks = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cliks == 65:
		position.x = 652
		position.y = 304
		visible = true



func _on_button_pressed():
	cliks += 1
	print(cliks)
	if cliks == 65:
		print("lul")
		visible = true
		position.x = 652
		position.y = 304
		print(visible)
		print(position)

