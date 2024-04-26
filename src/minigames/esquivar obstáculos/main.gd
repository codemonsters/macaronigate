extends Node2D

signal game_over
signal game_cleared
signal mouse_touch(event)

@export var game_brief = "esquivar obstáculos"
@export var needs_timer = true 
@export var timer_seconds = 10

var marmol = preload("res://minigames/esquivar obstáculos/marmol.tscn")
var area_movimiento = preload("res://minigames/esquivar obstáculos/area_movimiento.tscn")
var cuchara = preload("res://minigames/esquivar obstáculos/cuchara.tscn")
var cuchillo = preload("res://minigames/esquivar obstáculos/cuchillo.tscn")
var tenedor = preload("res://minigames/esquivar obstáculos/tenedor.tscn")
var sarten = preload("res://minigames/esquivar obstáculos/sarten.tscn")
var obstaculos = Array([cuchara, cuchillo, tenedor, sarten])
var separacion = 100
var i = 0
var num_plataformas
var distancia
var player_pos = Vector2(0, 0)
var num_plataforma = Vector2(0, 0)
var jump = false
var modulo_a = 0
var filas = 6
var marmol_anterior
var posicion_jugador = Vector2(2, 6)

var game_in_progress = true

func _ready():
	game_over.connect(Callable(get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent(), "on_game_cleared"))
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0,1))
	num_plataformas = 720/(118+separacion)
	num_plataformas = round(num_plataformas)
	distancia = (720 - (118*num_plataformas+separacion*(num_plataformas-1)))/2
	for y in range(filas):
		for x in range(num_plataformas+y%2):
			var marmol2 = marmol.instantiate()
			var area_movimiento2 = area_movimiento.instantiate()
			add_child(marmol2)
			add_child(area_movimiento2)
			if y == filas-1 and x == num_plataformas+y%2-2:
				marmol2.position=Vector2(2*59+separacion+marmol_anterior,200+150*y)
				area_movimiento2.position=Vector2(2*59+separacion+marmol_anterior,200+150*y)
			elif x == 0:
				marmol2.position=Vector2((distancia+26)*((y+1)%2)+33,200+150*y)
				area_movimiento2.position=Vector2((distancia+26)*((y+1)%2)+33,200+150*y)
			else:
				marmol2.position=Vector2(2*59+separacion+marmol_anterior,200+150*y)
				area_movimiento2.position=Vector2(2*59+separacion+marmol_anterior,200+150*y)
			marmol_anterior = marmol2.position.x
			print(area_movimiento2.position)
			mouse_touch.connect(Callable(area_movimiento2.get_node("Area2D"), "on_area_movimiento_mouse_touch"))

func _process(delta):
	if jump:
		if abs(num_plataforma.x - posicion_jugador.x) == 1 and num_plataforma.y - posicion_jugador.y == 0:
				$Jugador/CharacterBody2D.jump(delta, Vector2(num_plataforma.x - posicion_jugador.x, 0))
				if abs($Jugador/CharacterBody2D.position.x - player_pos.x) > 436:
					jump = false
					posicion_jugador = num_plataforma
					num_plataforma = Vector2(0, 0)
		elif int(posicion_jugador.y)%2 == 0:
			if num_plataforma.x - posicion_jugador.x == 0 and abs(num_plataforma.y - posicion_jugador.y) == 1:
				$Jugador/CharacterBody2D.jump(delta, Vector2(1, posicion_jugador.y - num_plataforma.y))
				if abs($Jugador/CharacterBody2D.position.x - player_pos.x) > 218 and abs($Jugador/CharacterBody2D.position.y - player_pos.y) > 250:
					jump = false
					posicion_jugador = num_plataforma
					num_plataforma = Vector2(0, 0)
			elif num_plataforma.x - posicion_jugador.x == -1 and abs(num_plataforma.y - posicion_jugador.y) == 1:
				$Jugador/CharacterBody2D.jump(delta, Vector2(-1, posicion_jugador.y - num_plataforma.y))
				if abs($Jugador/CharacterBody2D.position.x - player_pos.x) > 218 and abs($Jugador/CharacterBody2D.position.y - player_pos.y) > 250:
					jump = false
					posicion_jugador = num_plataforma
					num_plataforma = Vector2(0, 0)
			else:
				jump = false
		else:
			if num_plataforma.x - posicion_jugador.x == 1 and abs(num_plataforma.y - posicion_jugador.y) == 1:
				$Jugador/CharacterBody2D.jump(delta, Vector2(1, posicion_jugador.y - num_plataforma.y))
				if abs($Jugador/CharacterBody2D.position.x - player_pos.x) > 218 and abs($Jugador/CharacterBody2D.position.y - player_pos.y) > 250:
					jump = false
					posicion_jugador = num_plataforma
					num_plataforma = Vector2(0, 0)
			elif num_plataforma.x - posicion_jugador.x == 0 and abs(num_plataforma.y - posicion_jugador.y) == 1:
				$Jugador/CharacterBody2D.jump(delta, Vector2(-1, posicion_jugador.y - num_plataforma.y))
				if abs($Jugador/CharacterBody2D.position.x - player_pos.x) > 218 and abs($Jugador/CharacterBody2D.position.y - player_pos.y) > 250:
					jump = false
					posicion_jugador = num_plataforma
					num_plataforma = Vector2(0, 0)
			else:
				jump = false
	else:
		player_pos = $Jugador/CharacterBody2D.position
		$Jugador/CharacterBody2D.t = 0
	#i = randi_range(0, len(obstaculos)-1)
	#var obstaculo = obstaculos[i].instantiate()
	#add_child(obstaculo)
	#TODO Arreglar

	

func on_area_movimiento_mouse_touch(event):
	if not jump:
		for y in range(7):
			if event.position.y > (200+150*y-60) and event.position.y < (200+150*y+60):
				num_plataforma.y = y + 1
		if int(num_plataforma.y)%2 == 0:
			for x in range(5):
				if event.position.x > (33+218*x-50) and event.position.x < (33+218*x+50):
					num_plataforma.x = x + 1
		else:
			for x in range(4):
				if event.position.x > (142+218*x-50) and event.position.x < (142+218*x+50):
					num_plataforma.x = x + 1
		jump = true

func on_game_timeout():
	game_cleared.emit()
	game_in_progress = false
