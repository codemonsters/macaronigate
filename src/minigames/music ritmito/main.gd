extends Node2D
var Izq_scene = load("res://minigames/music ritmito/Izq.tscn")
var Der_scene = load("res://minigames/music ritmito/Der.tscn")
# Called when the node enters the scene tree for the first time.
var puedes_pular = false

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var der = Der_scene.instantiate()
	var izq = Izq_scene.instantiate()
	var bolitas = randi_range(1, 3)
	izq.position.y = -100
	der.position.y = -100
	if bolitas == 1:
		izq.position.x = 180
		add_child(izq)
	if bolitas == 2:	
		der.position.x = 540
		add_child(der)
	if bolitas == 3:
		izq.position.x = 180
		add_child(izq)
		der.position.x = 540
		add_child(der)





func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	puedes_pular = true
	print(puedes_pular)


func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	puedes_pular = false
	print(puedes_pular)
