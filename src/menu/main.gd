extends Node2D

var farfale_factory = preload("res://menu/pasta/farfalle.tscn")


func _ready():
	_on_pasta_constructor_timer_timeout()	# creates the first pasta without waiting for the timer to end
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 0.1))	# Establecemos la dirección de la gravedad hacia abajo (lo normal)

func _on_pasta_constructor_timer_timeout():
	# TODO: Añadir las imágenes de la pasta ya preescaladas al 25% para mejorar eficiencia?
	# TODO: Limitar la creación de pasta a un máximo (¿simplemente detener el timer?)
	# TODO: Agitar el móvil podría dar un empujón a la pasta creada, girarlo podría modificar la dirección del vector gravedad
	var pasta = farfale_factory.instantiate()
	pasta.position.x = randi_range(0, 720)
	pasta.rotation = randf_range(0, 2 * PI)
	pasta.angular_velocity = randf_range(-10, 10)
	$PastaContainer.add_child(pasta)
