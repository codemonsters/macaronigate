extends Node2D
#Sonido hipopótamo: Mummy Zombie - Mike Koenig en soundbible.com/1059-Mummy-Zombie.html
var madera = preload("res://minigames/happyhippo/madera.tscn")
var pared = preload("res://minigames/happyhippo/pared.tscn")
var separacion = 100
var num_plataformas
var distancia



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	num_plataformas = 720/(118+separacion)
	num_plataformas = round(num_plataformas)
	distancia = (720 - (118*num_plataformas+separacion*(num_plataformas-1)))/2
	for y in range(6):
		for x in range(num_plataformas+y%2):
			var madera2 = madera.instantiate()
			add_child(madera2)
			madera2.position=Vector2((distancia)*((y+1)%2)+59+(2*59+separacion+(randi() % 41 - 20))*x,200+150*y)
			if randi()%3 == 0:
				var pared2 = pared.instantiate()
				add_child(pared2)
				pared2.position=madera2.position+Vector2(53,-50)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, $watermelon.direction)
