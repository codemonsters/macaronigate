extends Node



func _ready():
	pass

# Called when the node enters the scene tree for the first time.
	

func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.


func get_width():
	return $CollisionShape2D.shape.size[0]
