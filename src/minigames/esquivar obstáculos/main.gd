extends Node2D

signal game_over
signal game_cleared

@export var game_brief = "esquivar obstáculos"
@export var needs_timer = true 
@export var timer_seconds = 10

var marmol = preload("res://minigames/esquivar obstáculos/marmol.tscn")
var separacion = 100
var num_plataformas
var distancia
var modulo_a = 0
var filas = 6
var marmol_anterior

var game_in_progress = true

func _ready():
	game_over.connect(Callable(get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent(), "on_game_cleared"))
	randomize()
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0,1))
	num_plataformas = 720/(118+separacion)
	num_plataformas = round(num_plataformas)
	distancia = (720 - (118*num_plataformas+separacion*(num_plataformas-1)))/2
	for y in range(filas):
		for x in range(num_plataformas+y%2):
			var marmol2 = marmol.instantiate()
			add_child(marmol2)
			if y == filas-1 and x == num_plataformas+y%2-2:
				marmol2.position=Vector2(2*59+separacion+marmol_anterior,200+150*y)
			elif x == 0:
				marmol2.position=Vector2((distancia)*((y+1)%2)+59,200+150*y)
			else:
				marmol2.position=Vector2(2*59+separacion+(randi() % 36 - 35)+marmol_anterior,200+150*y)
			marmol_anterior = marmol2.position.x 
	
func _process(delta):
	pass
	
func on_game_timeout():
	game_cleared.emit()
	game_in_progress = false
