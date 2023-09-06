extends CharacterBody2D


@export var SPEED = 600.0
var paddle_height
var screen_size

func _ready():
	paddle_height = $ColorRect.size.y
	screen_size = get_viewport_rect().size


func _physics_process(delta):
	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("up"):
		if position.y >= 0:
			input_dir.y -= 1
	if Input.is_action_pressed("down"):
		if position.y + paddle_height <= screen_size.y:
			input_dir.y += 1

	velocity = input_dir.normalized() * SPEED
	move_and_collide(velocity * delta)
