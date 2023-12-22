extends Node3D

var red_light_energy = 100
var blue_light_energy = 600

func _ready():
	$azulpolicia.light_energy = blue_light_energy
	$rojopolicia.light_energy = red_light_energy


func _on_blue_light_timer_timeout():
	if $azulpolicia.light_energy == 0:
		$azulpolicia.light_energy = blue_light_energy
	else:
		$azulpolicia.light_energy = 0
	
	$blueLightTimer.wait_time = 0.3
	$blueLightTimer.start()


func _on_red_light_timer_timeout():
	if $rojopolicia.light_energy == 0:
		$rojopolicia.light_energy = red_light_energy
	else:
		$rojopolicia.light_energy = 0
	
	$redLightTimer.wait_time = 0.3
	$redLightTimer.start()
