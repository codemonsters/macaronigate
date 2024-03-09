extends Node2D

var conchiglie_factory = preload("res://menu/pasta/conchiglie.tscn")
var farfale_factory = preload("res://menu/pasta/farfalle.tscn")
var fusilli_factory = preload("res://menu/pasta/fusilli.tscn")
var lumaconi_factory = preload("res://menu/pasta/lumaconi.tscn")
var macaroni_factory = preload("res://menu/pasta/macaroni.tscn")
var penne_factory = preload("res://menu/pasta/penne.tscn")


func _ready():
	_on_pasta_constructor_timer_timeout()	# creates the first pasta without waiting for the timer to end
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 0.1))	# Establecemos la dirección de la gravedad hacia abajo (lo normal)
	
	
func _on_pasta_constructor_timer_timeout():
	# TODO: Añadir las imágenes de la pasta ya preescaladas al 25% para mejorar eficiencia?
	# TODO: Limitar la creación de pasta a un máximo (¿simplemente detener el timer?)
	# TODO: Agitar el móvil podría dar un empujón a la pasta creada, girarlo podría modificar la dirección del vector gravedad
	var pasta
	var i = randi_range(0, 5)
	match i:
		0:
			pasta = conchiglie_factory.instantiate()
		1:
			pasta = farfale_factory.instantiate()
		2:
			pasta = fusilli_factory.instantiate()
		3:
			pasta = lumaconi_factory.instantiate()
		4:
			pasta = macaroni_factory.instantiate()
		5:
			pasta = penne_factory.instantiate()
			
	pasta.position.x = randi_range(0, 720)
	pasta.rotation = randf_range(0, 2 * PI)
	pasta.angular_velocity = randf_range(-10, 10)
	$PastaContainer.add_child(pasta)
