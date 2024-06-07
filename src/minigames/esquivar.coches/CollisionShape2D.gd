extends CollisionShape2D

var main


func _ready():
	main = get_parent().get_parent()


func _process(delta):
	if (main.in_game == true):
		position.y = position.y + (1000*delta)
