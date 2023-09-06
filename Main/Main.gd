extends Node2D

var screen_size
var player_paddle_size
var ai_paddle_size
var ball_size
var ghost_ball_class
var player_score = 0
var paddle_score = 0
var game_ongoing
@export var paddle_displacement = 50

signal reset_ball

func set_paddle_positions():
	var center_of_screen = screen_size.y / 2
	$PlayerPaddle.position.x = 0 + paddle_displacement
	$PlayerPaddle.position.y = center_of_screen - player_paddle_size.y / 2
	$AIPaddle.position.x = screen_size.x - paddle_displacement * 2
	$AIPaddle.position.y = center_of_screen - ai_paddle_size.y / 2


func ball_exists():
	if is_instance_valid($Ball):
		print("$Ball exists")
		return true
	else:
		print("$Ball does not exist")
		return false


func calculate_initial_ball_position(ball):
	var ball_size = ball.get_child(1).size
	var initial_ball_position = Vector2()
	initial_ball_position.x = screen_size.x / 2 - ball_size.x / 2
	initial_ball_position.y = screen_size.y / 2 - ball_size.y / 2
	return initial_ball_position


func handle_ball_spawn():
	if ball_exists():
		$Ball.queue_free()

	var ball = preload("res://Ball/Ball.tscn").instantiate()
	# Set initial position
	ball.position = calculate_initial_ball_position(ball)
	add_child(ball)
	# Connect the signal to AIPaddle's function
	var ai_paddle = $AIPaddle
	ball.final_ball_destination.connect(ai_paddle._on_ball_final_ball_destination)
	ball.paddle_won.connect(_on_ball_paddle_won)
	ball.player_won.connect(_on_ball_player_won)
	ball.ball_speed_increased.connect(_on_ball_speed_increased)


func position_menus():
	$PauseMenu.position = screen_size / 2
	$GameHUD.position.x = screen_size.x / 2


func initialize_menus():
	position_menus()
	$GameHUD/CurrentSpeed.text = "SPEED: " + str($Ball.speed)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	ghost_ball_class = preload("res://Debugging/Ball_Ghost.tscn")
	screen_size = get_viewport().get_visible_rect().size
	player_paddle_size = $PlayerPaddle/ColorRect.size
	ai_paddle_size = $AIPaddle/ColorRect.size
	handle_ball_spawn()
	ball_size = $Ball/ColorRect.size
	set_paddle_positions()
	initialize_menus()
	game_ongoing = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		$PauseMenu.show()


func _on_ball_summon_ghost_ball(predicted_position):
	print("Trying to spawn ghost ball at ", predicted_position)
	var ghost_ball = ghost_ball_class.instantiate()
	add_child(ghost_ball)
	ghost_ball.position = predicted_position
	var ghost_ball_timer = ghost_ball.get_child(1)
	ghost_ball_timer.start()


func _on_ball_paddle_won():
	if game_ongoing:
		paddle_score += 1
		print("Paddle won!")
		game_ongoing = false
		$GameResetTimer.start()
		$DespawnBallTimer.start()
		$GameHUD/AIScore.text = str(paddle_score)


func _on_ball_player_won():
	if game_ongoing:
		player_score += 1
		print("Player won!")
		game_ongoing = false
		$GameResetTimer.start()
		$DespawnBallTimer.start()
		$GameHUD/PlayerScore.text = str(player_score)


func _on_game_reset_timer_timeout():
	# Resets game
	_ready()
	emit_signal("reset_ball")


func _on_despawn_ball_timer_timeout():
	$Ball.queue_free()
	
	
func _on_ball_speed_increased():
	$GameHUD/CurrentSpeed.text = "SPEED: " + str($Ball.speed)
