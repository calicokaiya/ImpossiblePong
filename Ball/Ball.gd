extends Area2D

@export var speed = 600
var screen_size
var ball_size
var velocity = Vector2.ZERO
var debug

signal summon_ghost_ball
signal final_ball_destination
signal paddle_won
signal player_won
signal ball_speed_increased


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().get_visible_rect().size
	ball_size = $ColorRect.size
	$BallStartTimer.start()
	# Load ball speed from settings
	speed = Settings.ball_speed
	debug = Settings.debug
	print(debug)
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#velocity = Vector2.ZERO # The player's movement vector.

	# Limits ball to the Y axis
	if position.y <= 0 or ball_size.y + position.y >= screen_size.y:
		velocity.y *= -1
		
	# Determines who won
	if position.x < 0:
		emit_signal("paddle_won")
	if position.x > screen_size.x:
		emit_signal("Player won")

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta


func calculate_time_to_x(x):
	# Calculate the time to reach AIPaddle's X coordinate
	var delta_x = x - position.x
	return delta_x / velocity.x


func predict_position_at_x(target_x, time_to_x):
	var vertical_displacement = velocity.y * time_to_x
	var predicted_y = position.y + vertical_displacement
	
	while predicted_y < 0 or predicted_y > screen_size.y - ball_size.y:
		if predicted_y < 0:
			# Ball hit the top wall, invert the velocity
			predicted_y = -predicted_y
		else:
			# Ball hit the bottom wall, invert the velocity
			predicted_y = 2 * screen_size.y - predicted_y - ball_size.y * 2
	
	# Round the predicted_y value to a reasonable precision
	predicted_y = round(predicted_y)
		
	return Vector2(target_x, predicted_y)


func normalize_paddle_difference(body):
	# get initial info
	var paddle_position = body.position
	var paddle_colorrect = body.get_child(1)
	var paddle_height = paddle_colorrect.size.y
	var ball_height = $ColorRect.size
	
	# calculate centered difference
	var centered_paddle_height = paddle_height / 2 + paddle_position.y
	var centered_ball_height = ball_height.y / 2 + position.y
	var difference = centered_paddle_height - centered_ball_height
	
	# calculate normalize difference
	# the normalized difference is where the ball hit the paddle ...
	# from -1 to 1, where 0 is the center.
	var max_difference = (paddle_height / 2) + (ball_height.y / 2)
	var normalized_difference = difference / max_difference
	
	return -normalized_difference


func predict_ball_destination(velocity):
	#if position.x
	var target_x = screen_size.x - 50 - 90
	var time_to_x = calculate_time_to_x(target_x)
	var predicted_position = predict_position_at_x(target_x, time_to_x)
	emit_signal("final_ball_destination", predicted_position, ball_size.y)
	
	if Settings.debug == "yes":
		print("Debug mode is activated!")
		emit_signal("summon_ghost_ball", predicted_position) # DEBUG LINE


func _on_body_entered(body):
	
	var paddle_difference = normalize_paddle_difference(body)
	velocity.x *= -1
	velocity.y = paddle_difference * speed
		
	# Predict where the ball will be by the time it reaches the AI Paddle
	if position.x < screen_size.x / 2:
		predict_ball_destination(velocity)



func _on_ball_start_timer_timeout():
	var rng = RandomNumberGenerator.new()
	var chosen_direction = randi_range(-1, 1)
	while chosen_direction == 0:
		chosen_direction = randi_range(-1, 1)
	velocity.x = chosen_direction
	predict_ball_destination(velocity)
	$IncreaseBallSpeedTimer.start()


func _on_increase_ball_speed_timer_timeout():
	print("Increasing ball speed to ", speed + 50)
	speed += 50
	emit_signal("ball_speed_increased")
