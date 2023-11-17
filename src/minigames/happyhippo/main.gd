extends Node2D
#Sonido hipopótamo: Mummy Zombie - Mike Koenig en soundbible.com/1059-Mummy-Zombie.html
var madera = preload("res://minigames/happyhippo/madera.tscn")
var pared = preload("res://minigames/happyhippo/pared.tscn")
var separacion = 100
var num_plataformas
var distancia
var direction = Vector2(0,1)
var angulo = 0
var filas = 6
var madera_anterior


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	num_plataformas = 720/(118+separacion)
	num_plataformas = round(num_plataformas)
	distancia = (720 - (118*num_plataformas+separacion*(num_plataformas-1)))/2
	for y in range(filas):
		for x in range(num_plataformas+y%2):
			var madera2 = madera.instantiate()
			add_child(madera2)
			if y == filas-1 and x == num_plataformas+y%2-2:
				madera2.position=Vector2(2*59+separacion+madera_anterior,200+150*y)
			elif x == 0:
				madera2.position=Vector2((distancia)*((y+1)%2)+59,200+150*y)
			else:
				madera2.position=Vector2(2*59+separacion+(randi() % 41 - 40)+madera_anterior,200+150*y)
			if randi()%3 == 0 and y > 0:
				var pared2 = pared.instantiate()
				add_child(pared2)
				pared2.position=madera2.position+Vector2(53,-50)
			madera_anterior = madera2.position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	angulo += Input.get_gyroscope().x*delta
	if angulo > 3.14/2:
		angulo = 3.14/2
	elif angulo < -3.14/2:
		angulo = -3.14/2
	direction = Vector2(sin(angulo),cos(angulo))
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, direction)
