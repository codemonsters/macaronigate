# Macaronigate (Il Assurdo Caso del Vitello Rubato)

You can try out the [web version](https://tyo.ovh/experiments/macarronigate/) (testing build not up-to-date)

## Minigame integration
Sample main script (attached to main.tscn inside the minigame subfolder)
```gdscript
extends Node2D
# Declare the required signals
signal game_over
signal game_cleared

# Required variables
@export var game_brief = "Brief Game Explanation/Title!"
@export var needs_timer = true # False if your game doesn't need a countdown timer
@export var timer_seconds = 5 # Only set if needs_timer = true

func _ready():
    # Connect the appropriate signals to the funtions in game.gd
    game_over.connect(Callable(get_parent(), "on_game_over"))
    game_cleared.connect(Callable(get_parent(), "on_game_cleared"))

# Your minigame shouldn't start until the "on_game_start" function is triggered on your script
func on_game_start():
	$YourTimer.start() # For example, you can start your enemy spawn timer here

# When the game timer (if enabled) times out, the "on_game_timeout" function is triggered on your script
func on_game_timeout():
    game_cleared.emit() # In this example the game is cleared if the player survived
```
Now, according to your game logic, you can send ```game_over``` and ```game_cleared``` as appropriate.
```gdscript
game_over.emit()
game_cleared.emit()
```
or developing, inside the menu click "Pick Game" and pick your game.
Alternatively, inside ```game.gd```, set ```launch_minigame_directly``` to the name of your minigame's subfolder, and then start the project normally using F5
```gdscript
# game.gd explanation:
# Array with the name of the minigames that will be played
var minigames = ["frutas", "esquivar.coches"]
# If you want to launch specific minigames in a specific order
# var minigames_order_override = ["ñarkanoid", "pizzaCatch"]
var minigames_order_override = null
```
