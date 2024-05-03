extends Node2D

signal game_over
signal game_cleared

# Imágen de fondo (sabana): https://get.pxhere.com/photo/landscape-tree-nature-marsh-swamp-meadow-prairie-lake-green-pasture-soil-savanna-waterway-plain-watering-hole-grassland-wetland-bog-floodplain-plateau-habitat-ecosystem-lone-tree-steppe-nature-reserve-namibia-etosha-natural-environment-geographical-feature-land-lot-632302.jpg
# Sonido hipopótamo: Mummy Zombie - Mike Koenig en soundbible.com/1059-Mummy-Zombie.html
# Sonido agua: Water Churning - Mark Diangelo en soundbible.com/1790-Water-Churning.html
# Sonido sandía siendo comida: Neck Breaking - Mike Koening en soundbible.com/404-Neck-Breaking.html
# Sonido perder: Flush Toilet 2 - Mike Koening en soundbible.com/2114-Flush-Toilet--2.html

@export var game_brief = "Willing Hippo"
@export var needs_timer = true # False if your game doesn't need a countdown timer
@export var timer_seconds = 10 # Only set if needs_timer = truen timer
@export var factor_gravedad = 1.75
@export var shake_threshold = 100

var madera = preload("res://minigames/willinghippo/madera.tscn")
var pared = preload("res://minigames/willinghippo/pared.tscn")
var separacion = 100
var num_plataformas
var distancia
var direction = Vector2(0,1)
var aceleracion = Vector3(0,0,0)
var modulo_a = 0
var angulo = 0
var filas = 6
var madera_anterior

var game_in_progress = true # Añadí esta variable porque el juego estaba emitiendo "game_cleared" demasiadas veces



# Called when the node enters the scene tree for the first time.
func _ready():
	game_over.connect(Callable(get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent(), "on_game_cleared"))
	randomize()
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0,-1))
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
				madera2.position=Vector2(2*59+separacion+(randi() % 36 - 35)+madera_anterior,200+150*y)
			if randi()%3 == 0 and y > 0:
				var pared2 = pared.instantiate()
				add_child(pared2)
				pared2.position=madera2.position+Vector2(53,-48)
			madera_anterior = madera2.position.x

func _input(event):
	if Input.is_key_pressed(KEY_RIGHT):
		angulo = .3
	if Input.is_key_pressed(KEY_LEFT):
		angulo = -.3
	if Input.is_key_pressed(KEY_UP):
		jump()

func jump():
	if angulo == 3.14:
		angulo = 0
	else:
		angulo = 3.14

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	angulo += Input.get_gyroscope().x*delta
	aceleracion += Input.get_accelerometer()*delta
	modulo_a = sqrt(aceleracion.x**2 + aceleracion.y**2 + aceleracion.z**2)
	if angulo > 3.14/2 and angulo != 3.14:
		direction = factor_gravedad * Vector2(sin(3.14/2),cos(3.14/2))
	elif angulo < -3.14/2 and angulo != 3.14:
		direction = factor_gravedad * Vector2(sin(-3.14/2),cos(-3.14/2))
	else:
		direction = factor_gravedad * Vector2(sin(angulo),cos(angulo))
	if modulo_a > shake_threshold:
		jump()
	if (game_in_progress):
		PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, direction)
		if $Hipopotamo.overlaps_body($watermelon/RigidBody2D):
			eat()
			game_cleared.emit()
			PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0,1))
			game_in_progress = false
		if ($LimiteIzquierda.overlaps_body($watermelon/RigidBody2D) or $LimiteDerecha.overlaps_body($watermelon/RigidBody2D) or $LimiteArriba.overlaps_body($watermelon/RigidBody2D) or $LimiteAbajo.overlaps_body($watermelon/RigidBody2D)):
			game_over.emit()
			PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0,1))
			game_in_progress = false

func on_game_timeout():
	game_over.emit()
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0,1))
	game_in_progress = false
	
func eat():
	$hippo_mouth.rotate(-1)
	
	
	
