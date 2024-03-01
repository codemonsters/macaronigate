extends Sprite2D

var cliks = 0 

func _ready():
	pass

func _process(delta):
	pass


func _on_button_pressed():
	cliks += 1
	scale.x += 0.01
	scale.y += 0.01
	
	if cliks == 65:
		visible = false
