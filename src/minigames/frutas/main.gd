extends Node2D

# Juan https://ninjikin.itch.io/fruit

@export var fruta_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var fruta = fruta_scene.instantiate()
	#fruta.position(100, 100)
	add_child(fruta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
