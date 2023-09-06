extends Node

var ball_speed
var debug = "yes"

func load_settings():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		ball_speed = config.get_value("game_settings/ball_speed", str(ball_speed), 1000)
		debug = config.get_value("game_settings/debug", "yes")
		print("Loaded config")
		print("ball_speed: ", ball_speed)
		print("debug: ", debug)

func save_settings():
	var config = ConfigFile.new()
	config.set_value("game_settings", "ball_speed", ball_speed)
	config.set_value("game_settings", "debug", "yes")
	config.save("user://settings.cfg")
	print("Saved settings:")
	print(config.get_value("game_settings/ball_speed", str(ball_speed)))

# Called when the node enters the scene tree for the first time.
func _ready():
	load_settings()
	# Use ball_speed to set the actual ball speed in your game logic
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
