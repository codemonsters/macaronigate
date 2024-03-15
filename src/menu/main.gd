extends Node2D

# Credits:
# * Background image found here: https://www.pexels.com/photo/narrow-alley-in-town-in-italy-19560864/

@export var pasta_max = 150	# maximum number of pasta instances to create

var conchiglie_factory = preload("res://menu/pasta/conchiglie.tscn")
var farfale_factory = preload("res://menu/pasta/farfalle.tscn")
var fusilli_factory = preload("res://menu/pasta/fusilli.tscn")
var lumaconi_factory = preload("res://menu/pasta/lumaconi.tscn")
var macaroni_factory = preload("res://menu/pasta/macaroni.tscn")
var penne_factory = preload("res://menu/pasta/penne.tscn")
var pasta_num = 0	# number of pasta bodies instanciated

func _ready():
	pasta_num = 0
	_on_pasta_constructor_timer_timeout()	# creates the first pasta without waiting for the timer to end
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 1))	# Establecemos la dirección de la gravedad hacia abajo (lo normal)

	
func _on_pasta_constructor_timer_timeout():
	if pasta_num >= pasta_max:
		$PastaConstructorTimer.stop()
		return

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
	pasta_num += 1
