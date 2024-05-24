extends Node2D

var localFloorNumber

func _ready():
	$AnimationPlayer.current_animation = "going_up"
	$arrowLight.play()
	$Dozens.animation = "numbers"
	$Units.animation = "numbers"
	
	

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "going_up":
		$AnimationPlayer.current_animation = "exiting_elevator"
		
		#Actualizamos el numero del ascensor
		localFloorNumber += 1
		$Dozens.frame = floor(localFloorNumber / 10)
		$Units.frame = localFloorNumber % 10
		
	elif anim_name == "exiting_elevator":
		get_parent().get_parent().on_elevator_exit()

func set_starting_floor_number(floorNumber): # Llamar a esta función antes de que el ascensor se ponga en marcha
	localFloorNumber = floorNumber
	$Dozens.frame = floor(floorNumber / 10)
	$Units.frame = floorNumber % 10
	
