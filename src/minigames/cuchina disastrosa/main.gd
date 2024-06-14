extends Node2D

signal game_over
signal game_cleared

# Sonido marmol: Rockslide small - Sound Explorer en soundbible.com/1987-Rockslide-Small.html
# Sonido perder: Sad Trombone - Joe Lamb en soundbible.com/1830-Sad-Trombone.html
# Sonido proyectil: Throw knife - Anonymous en soundbible.com/1607-Throw-Knife.html
# Sonido salto: Boing cartoonish - (no tiene nombre) en soundbible.com/266-Boing-Cartoonish.html 

@export var game_brief = "cuchina disastrosa"
@export var needs_timer = true 
@export var timer_seconds = 10
@export var instructions_type = "tap"

var marmol = preload("res://minigames/cuchina disastrosa/marmol.tscn")
var cuchara = preload("res://minigames/cuchina disastrosa/cuchara.tscn")
var cuchillo = preload("res://minigames/cuchina disastrosa/cuchillo.tscn")
var tenedor = preload("res://minigames/cuchina disastrosa/tenedor.tscn")
var sarten = preload("res://minigames/cuchina disastrosa/sarten.tscn")
var obstaculos = Array([cuchara, cuchillo, tenedor, sarten])
var obstaculos_instanciados = Array([])
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
			add_child(marmol2)
			if y == filas-1 and x == num_plataformas+y%2-2:
				marmol2.position=Vector2(2*59+separacion+marmol_anterior,200+150*y)
			elif x == 0:
				marmol2.position=Vector2((distancia+26)*((y+1)%2)+33,200+150*y)
			else:
				marmol2.position=Vector2(2*59+separacion+marmol_anterior,200+150*y)
			marmol_anterior = marmol2.position.x

func _process(delta):
	for o in obstaculos_instanciados:
		o[0].position.x += delta*200*(-1)**o[1]
		if o[0].position.x > 820 or o[0].position.x < -100:
			obstaculos_instanciados.erase(o)
		if o[0].get_child(1).overlaps_body($Jugador/CharacterBody2D):
			$Jugador/CharacterBody2D.die(delta)
			$Sonido_perder.play()
			game_over.emit()
	if jump:
		if num_plataforma.y < 1 or num_plataforma.y > 6:
			jump = false
		elif abs(num_plataforma.x - posicion_jugador.x) == 1 and num_plataforma.y - posicion_jugador.y == 0:
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


func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if not jump:
			for y in range(6):
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

func _on_timer_cubiertos_timeout():
	i = randi_range(0, len(obstaculos)-1)
	var obstaculo = obstaculos[i].instantiate()
	var sentido = 0
	var a = true
	$Sonido_proyectil.play()
	while a:
		sentido = randi_range(0,1)
		obstaculo.position = Vector2(sentido*720,randi_range(0,5)*150+100)
		a = false
		for o in obstaculos_instanciados:
			if o[0].position.y == obstaculo.position.y:
				a = true
	obstaculo.rotate(PI*sentido)
	add_child(obstaculo)
	obstaculos_instanciados.append([obstaculo, sentido])
	
	#Añadir el sonido del marmol y sonido de salto
	
	if jump:
		$Sonido_marmol.play()
	
