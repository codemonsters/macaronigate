extends Node2D
#Sonido hipopótamo: Mummy Zombie - Mike Koenig en soundbible.com/1059-Mummy-Zombie.html
var madera = preload("res://minigames/happyhippo/madera.tscn")
var separacion = 100
var num_plataformas
var distancia



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	num_plataformas = 720/(118+separacion)
	num_plataformas = round(num_plataformas)
	distancia = (720 - (118*num_plataformas+separacion*(num_plataformas-1)))/2
	for y in range(4):
		for x in range(num_plataformas+y%2):
			var madera2 = madera.instantiate()
			add_child(madera2)
			madera2.position=Vector2((distancia)*((y+1)%2)+59+(2*59+separacion+(randi() % 41 - 20))*x,200+200*y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
