extends CharacterBody2D


@export var SPEED = 600.0
var paddle_height
var screen_size
var direction = Vector2.ZERO
var calculated_paddle_position = Vector2.ZERO

func _ready():
	paddle_height = $ColorRect.size.y
	screen_size = get_viewport_rect().size


func _physics_process(delta):
	if calculated_paddle_position.length() > 0:
		# Calculate the difference between the current y-coordinate and the destination y-coordinate
		var y_diff = calculated_paddle_position.y - position.y

		# Check if the paddle is not already at the destination
		if abs(y_diff) > 1:  # You can adjust the threshold as needed
			# Determine the direction to move (up or down)
			var direction = sign(y_diff)	
			# Calculate the distance the paddle should move this frame
			var y_move = SPEED * delta * direction	
			# Ensure that the paddle doesn't overshoot the destination
			if abs(y_move) > abs(y_diff):
				y_move = y_diff

			# Make sure the paddle is within game limits
			# Update the paddle's position
			position.y += y_move
			position.y = clamp(position.y, 0, screen_size.y - paddle_height)


func calculate_paddle_position(ball_destination, ball_height):
	# Choos where to hit the ball
	var rng = RandomNumberGenerator.new()
	#var maximum_hit_choice = paddle_height / 2
	#var minimum_hit_choice = -maximum_hit_choice
	#var hit_position = randi_range(minimum_hit_choice, maximum_hit_choice)
	# min should not be hard coded
	var hit_position = randi_range(-35, -paddle_height + 5)
	
	#Center the ball in calculations
	var paddle_position = ball_destination
	paddle_position.y = ball_destination.y + hit_position
	
	#paddle_position.y = ball_destination.y - paddle_height / 2 + ball_height / 2
	return paddle_position


func _on_ball_final_ball_destination(ball_destination, ball_height):
	var paddle_position = calculate_paddle_position(ball_destination, ball_height)
	calculated_paddle_position = paddle_position
