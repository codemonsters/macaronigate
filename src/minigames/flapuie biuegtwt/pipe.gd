extends Node

signal pipe_body_entered

func _ready():
	pipe_body_entered.connect(Callable(get_parent().get_parent(), "_on_pipe_body_entered"))

# Called when the node enters the scene tree for the first time.
	

func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.


func get_width():
	return $CollisionShape2D.shape.size[0]


func _on_body_entered(body):
	pipe_body_entered.emit(body)
