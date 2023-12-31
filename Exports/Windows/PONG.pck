GDPC                �                                                                      !   T   res://.godot/exported/133200997/export-226510183ac18e76d59f98c279838799-GameHUD.scn �6      �      *@@@YWj$V/|����    X   res://.godot/exported/133200997/export-418aa4b5b5277b4fa9106e13595f1556-PlayerPaddle.scn�]      �      ׽��/��y�FrT)CF�    X   res://.godot/exported/133200997/export-42c4e1b2659fa5596d4388773675d19a-SettingsMenu.scn�Q      �	      |�"�p@;,k��    X   res://.godot/exported/133200997/export-7adf28ae5f4f56274d5082ddbc459574-Ball_Ghost.scn  �      �      f�)]G$��N�Lc�    X   res://.godot/exported/133200997/export-9a4cbcec44ad0903bb765ad03b95706c-PauseMenu.scn   pF            ��O���q���ʱ"fp    P   res://.godot/exported/133200997/export-9e50f8f041ee32305e0343a759165653-Ball.scnP      [      �"o�����e�B��%    T   res://.godot/exported/133200997/export-dc5659603021f6123da542ea8bcad841-MainMenu.scnP>      D      %�*���C�)���ypJR    P   res://.godot/exported/133200997/export-ebc741d9ca7bc58bf3f4d09c000e7715-Main.scnp0      #      ��9�sR�<��`�	    T   res://.godot/exported/133200997/export-fed5773a2d36fbc818b032cc3cddbb98-AIPaddle.scnp      �      ��W���B��×E�\    ,   res://.godot/global_script_class_cache.cfg   v             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�d      �      �Yz=������������       res://.godot/uid_cache.bin   z            ~�`�{� �t~��/       res://AIPaddle/AIPaddle.gd          p      ��<<�[."�l��@�    $   res://AIPaddle/AIPaddle.tscn.remap  0r      e       | ���p�xb�'"2k       res://Ball/Ball.gd  P      �      ��u�7�ι=���]T|       res://Ball/Ball.tscn.remap  �r      a       ��� ��F�:�*&�        res://Debugging/Ball_Ghost.gd   �      
      �|�1�Z�E���ݶ�    (   res://Debugging/Ball_Ghost.tscn.remap   s      g       �������fB
JP�S       res://Main/Main.gd  �#      �      �@:��g�:�;�qg�X       res://Main/Main.tscn.remap  �s      a       ��m��^�t��V�y��    (   res://Menus/GameHUD/GameHUD.tscn.remap  �s      d       h3�/���皸%1}�         res://Menus/MainMenu/MainMenu.gd`<      �      �ֱ
_��\��1Ȝ(�b    (   res://Menus/MainMenu/MainMenu.tscn.remap`t      e       ք�n�vʣ(G����        res://Menus/Pause/PauseMenu.gd  �D      �      n7�ŢU��=�n@$�l    (   res://Menus/Pause/PauseMenu.tscn.remap  �t      f       �q�C����P    $   res://Menus/Settings/SettingsMenu.gd�N      2      =6C yԵ�T��z�    ,   res://Menus/Settings/SettingsMenu.tscn.remap@u      i       ("���I�<g>.���    $   res://PlayerPaddle/PlayerPaddle.gd  �[      �      ���La0 S���>�'    ,   res://PlayerPaddle/PlayerPaddle.tscn.remap  �u      i       �$_2(�84�T� �       res://Singletons/Settings.gdpa            ��MK傰҆����~}       res://icon.svg  @v      �      C��=U���^Qu��U3       res://icon.svg.import   `q      �       i�d1�QU�~d�C�$       res://project.binary |      �
      ��1��Ց�Šڼ�    ���/extends CharacterBody2D


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
RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script    res://AIPaddle/AIPaddle.gd ��������      local://RectangleShape2D_qlw06 ]         local://PackedScene_kwy4n �         RectangleShape2D       
      B  C         PackedScene          	         names "   	   	   AIPaddle    script    CharacterBody2D    CollisionShape2D 	   position    shape 
   ColorRect    offset_right    offset_bottom    	   variants                 
     �A  �B                B     C      node_count             nodes        ��������       ����                            ����                                 ����                         conn_count              conns               node_paths              editable_instances              version             RSRC��#�Pextends Area2D

@export var speed = 600
var screen_size
var ball_size
var velocity = Vector2.ZERO
const debug = false

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
	var target_x = screen_size.x - 50 - 90
	var time_to_x = calculate_time_to_x(target_x)
	var predicted_position = predict_position_at_x(target_x, time_to_x)
	emit_signal("final_ball_destination", predicted_position, ball_size.y)
	
	if debug == true:
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
��v�e_RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script    res://Ball/Ball.gd ��������      local://RectangleShape2D_ab0fm U         local://PackedScene_02t6x �         RectangleShape2D       
      B   B         PackedScene          	         names "         Ball    script    metadata/_edit_group_    Area2D    CollisionShape2D 	   position    shape 
   ColorRect    offset_right    offset_bottom    BallStartTimer 	   one_shot    Timer    IncreaseBallSpeedTimer 
   wait_time    _on_body_entered    body_entered    _on_ball_start_timer_timeout    timeout &   _on_increase_ball_speed_timer_timeout    	   variants                       
     �A  �A                B     �@      node_count             nodes     3   ��������       ����                                  ����                                 ����         	                     
   ����                           ����                   conn_count             conns                                                                                       node_paths              editable_instances              version             RSRC��P��extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	self.queue_free()
�W��RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Debugging/Ball_Ghost.gd ��������      local://PackedScene_itt5i          PackedScene          	         names "         Ball 	   position    script    metadata/_edit_group_    Area2D 
   ColorRect    z_index    offset_right    offset_bottom    color    Timer 
   wait_time    _on_timer_timeout    timeout    	   variants       
    �D  �C                   ����      B     �?  �?  �?���>     @@      node_count             nodes     %   ��������       ����                                        ����                     	                  
   
   ����                   conn_count             conns                                      node_paths              editable_instances              version             RSRCe[i;�extends Node2D

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
	$GameHUD/AIScore.text = "0"
	$GameHUD/PlayerScore.text = "0"
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


func _on_ball_player_won():
	if game_ongoing:
		player_score += 1
		print("Player won!")
		game_ongoing = false
		$GameResetTimer.start()
		$DespawnBallTimer.start()


func _on_game_reset_timer_timeout():
	# Resets game
	_ready()
	emit_signal("reset_ball")


func _on_despawn_ball_timer_timeout():
	$Ball.queue_free()
	
	
func _on_ball_speed_increased():
	$GameHUD/CurrentSpeed.text = "SPEED: " + str($Ball.speed)
RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Main/Main.gd ��������   PackedScene !   res://Menus/Pause/PauseMenu.tscn NB��	+D   PackedScene !   res://Menus/GameHUD/GameHUD.tscn i}�D��:B   PackedScene %   res://PlayerPaddle/PlayerPaddle.tscn όU�2V   PackedScene    res://AIPaddle/AIPaddle.tscn Q�$�Oh      local://PackedScene_j1ave �         PackedScene          	         names "         Node2D    process_mode    script 
   PauseMenu    visible    GameHUD    offset_left    offset_top    offset_right    offset_bottom    PlayerPaddle 	   AIPaddle    GameResetTimer 
   wait_time 	   one_shot    Timer    DespawnBallTimer    _on_game_reset_timer_timeout    timeout    _on_despawn_ball_timer_timeout    	   variants                                                    �D     PA                       �?            ?      node_count             nodes     G   ��������        ����                            ���                           ���                           	                  ���
                      ���                            ����      	      
                     ����            
             conn_count             conns                                                              node_paths              editable_instances              version             RSRC*%�qkdLs�C��'RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script           local://PackedScene_qt0j4 �          PackedScene          	         names "         GameHUD    layout_mode    anchors_preset    anchor_left    anchor_right    grow_horizontal    Control    PlayerScore    offset_left    offset_top    offset_right    offset_bottom $   theme_override_font_sizes/font_size    text    Label    AIScore    CurrentSpeed    anchor_top    anchor_bottom    grow_vertical    	   variants                         ?                @��     �A    ���     �B   (         0      �C     �C           �?     V�    �D     VB     (D                   SPEED:        node_count             nodes     n   ��������       ����                                                    ����                                 	      
                     	      
                     ����                                 	      
                     	      
                     ����                                             	      
                                              conn_count              conns               node_paths              editable_instances              version             RSRC��(\��}PUU&�yextends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Main/Main.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Menus/Settings/SettingsMenu.tscn")
���E�_%� ��;�RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script !   res://Menus/MainMenu/MainMenu.gd ��������      local://PackedScene_dkvri          PackedScene          	         names "      	   MainMenu    layout_mode    anchors_preset    script    Control    Label    offset_left    offset_top    offset_right    offset_bottom $   theme_override_font_sizes/font_size    text 
   StartGame    Button    Options    Quit    _on_start_game_pressed    pressed    _on_options_pressed    _on_quit_pressed    	   variants                                   �C     =C     _D    ��C   <         IMPOSSIBLE PONG     @D    ��C    �'D     �C   (         Start      D    ��C    �.D     �C      Options      �C     D     BD    �D      Quit to Desktop
       node_count             nodes     a   ��������       ����                                        ����                           	      
                              ����            	      
         	      
                              ����                           	      
                              ����                           	      
                      conn_count             conns                                                                                      node_paths              editable_instances              version             RSRC����uK�#�Ԡ�extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resume_pressed():
	get_tree().paused = false
	hide()


func _on_quit_pressed():
	get_tree().quit()


func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/MainMenu/MainMenu.tscn")
	
v�����R����RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Menus/Pause/PauseMenu.gd ��������      local://PackedScene_lnkbv          PackedScene          	         names "      
   PauseMenu    process_mode    z_index    layout_mode    anchors_preset    anchor_right    anchor_bottom    offset_left    offset_right    grow_horizontal    grow_vertical    script    Control    Resume    anchor_left    anchor_top    offset_top    offset_bottom $   theme_override_font_sizes/font_size    text    Button 	   MainMenu    Quit    PausedLabel    Label    _on_resume_pressed    pressed    _on_main_menu_pressed    _on_quit_pressed    	   variants                                    �?                      ?     ��     ��     �B     �A   (         Resume
      �     2B     C     �B      Return to Menu      �     �B     C    �6C      Exit to Desktop      ��     ?�     �B     ��   <         Pause       node_count             nodes     �   ��������       ����                                                    	       
                               ����                                                	      
         	       
                                     ����                                                               	       
                                     ����                                                               	       
                                     ����                                                               	       
                             conn_count             conns                                                                                      node_paths              editable_instances              version             RSRC`�j>��extends Control

var ball_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	ball_speed = Settings.ball_speed
	$CurrentSpeedLabel.text = str(ball_speed)
	$CurrentSpeedHSlider.value = ball_speed
	print($CurrentSpeedHSlider.value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_current_speed_h_slider_value_changed(value):
	$CurrentSpeedLabel.text = str(value)


func _on_current_speed_h_slider_drag_ended(value_changed):
	Settings.ball_speed = value_changed


func _on_save_settings_button_pressed():
	print("Ball speed to be set: ", $CurrentSpeedHSlider.value)
	Settings.ball_speed = int($CurrentSpeedLabel.text)
	Settings.save_settings()
	get_tree().change_scene_to_file("res://Menus/MainMenu/MainMenu.tscn")

/�q�� �	�����RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script %   res://Menus/Settings/SettingsMenu.gd ��������      local://PackedScene_wfbtc          PackedScene          	         names "   $   	   Settings    layout_mode    anchors_preset    anchor_left    anchor_top    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control    Ball Speed    offset_left    offset_top    offset_right    offset_bottom $   theme_override_font_sizes/font_size    text    Label    CurrentSpeedHSlider 
   min_value 
   max_value    step    value    tick_count    ticks_on_borders    HSlider    CurrentSpeedLabel    SaveSettingsButton    Button &   _on_current_speed_h_slider_drag_ended    drag_ended )   _on_current_speed_h_slider_value_changed    value_changed !   _on_save_settings_button_pressed    pressed    	   variants    $                     ?                           ��     ��     �B     �   (         Ball Speed
      ��    ���     �B     u�   <      	   Settings      h�     ��     (C     0�     �B     �D                 2C     ��     ZC     �?      500     ��    �PC    �C    ��C      Save Settings       node_count             nodes     �   ��������
       ����	                                                    	                        ����                                                            	                  
                            ����                                                                                                         ����                                                                                                                                 ����                                                                                                         ����                                                       !      "                  
      #             conn_count             conns                                       !                         #   "                    node_paths              editable_instances              version             RSRC�Ę��0� -�@cextends CharacterBody2D


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
3 ��~5�#ERSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script #   res://PlayerPaddle/PlayerPaddle.gd ��������      local://RectangleShape2D_qlw06 e         local://PackedScene_cwy1o �         RectangleShape2D       
      B  C         PackedScene          	         names "   	      PlayerPaddle    script    CharacterBody2D    CollisionShape2D 	   position    shape 
   ColorRect    offset_right    offset_bottom    	   variants                 
     �A  �B                B     C      node_count             nodes        ��������       ����                            ����                                 ����                         conn_count              conns               node_paths              editable_instances              version             RSRC�3��h}�P��extends Node

var ball_speed = 1000

func load_settings():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		ball_speed = config.get_value("game_settings/ball_speed", str(ball_speed), 1000)

func save_settings():
	var config = ConfigFile.new()
	config.set_value("game_settings", "ball_speed", ball_speed)
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
�ҠUɇM��LGST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح����mow�*��f�&��Cp�ȑD_��ٮ}�)� C+���UE��tlp�V/<p��ҕ�ig���E�W�����Sթ�� ӗ�A~@2�E�G"���~ ��5tQ#�+�@.ݡ�i۳�3�5�l��^c��=�x�Н&rA��a�lN��TgK㼧�)݉J�N���I�9��R���$`��[���=i�QgK�4c��%�*�D#I-�<�)&a��J�� ���d+�-Ֆ
��Ζ���Ut��(Q�h:�K��xZ�-��b��ٞ%+�]�p�yFV�F'����kd�^���:[Z��/��ʡy�����EJo�񷰼s�ɿ�A���N�O��Y��D��8�c)���TZ6�7m�A��\oE�hZ�{YJ�)u\a{W��>�?�]���+T�<o�{dU�`��5�Hf1�ۗ�j�b�2�,%85�G.�A�J�"���i��e)!	�Z؊U�u�X��j�c�_�r�`֩A�O��X5��F+YNL��A��ƩƗp��ױب���>J�[a|	�J��;�ʴb���F�^�PT�s�)+Xe)qL^wS�`�)%��9�x��bZ��y
Y4�F����$G�$�Rz����[���lu�ie)qN��K�<)�:�,�=�ۼ�R����x��5�'+X�OV�<���F[�g=w[-�A�����v����$+��Ҳ�i����*���	�e͙�Y���:5FM{6�����d)锵Z�*ʹ�v�U+�9�\���������P�e-��Eb)j�y��RwJ�6��Mrd\�pyYJ���t�mMO�'a8�R4��̍ﾒX��R�Vsb|q�id)	�ݛ��GR��$p�����Y��$r�J��^hi�̃�ūu'2+��s�rp�&��U��Pf��+�7�:w��|��EUe�`����$G�C�q�ō&1ŎG�s� Dq�Q�{�p��x���|��S%��<
\�n���9�X�_�y���6]���մ�Ŝt�q�<�RW����A �y��ػ����������p�7�l���?�:������*.ո;i��5�	 Ύ�ș`D*�JZA����V^���%�~������1�#�a'a*�;Qa�y�b��[��'[�"a���H�$��4� ���	j�ô7�xS�@�W�@ ��DF"���X����4g��'4��F�@ ����ܿ� ���e�~�U�T#�x��)vr#�Q��?���2��]i�{8>9^[�� �4�2{�F'&����|���|�.�?��Ȩ"�� 3Tp��93/Dp>ϙ�@�B�\���E��#��YA 7 `�2"���%�c�YM: ��S���"�+ P�9=+D�%�i �3� �G�vs�D ?&"� !�3nEФ��?Q��@D �Z4�]�~D �������6�	q�\.[[7����!��P�=��J��H�*]_��q�s��s��V�=w�� ��9wr��(Z����)'�IH����t�'0��y�luG�9@��UDV�W ��0ݙe)i e��.�� ����<����	�}m֛�������L ,6�  �x����~Tg����&c�U��` ���iڛu����<���?" �-��s[�!}����W�_�J���f����+^*����n�;�SSyp��c��6��e�G���;3Z�A�3�t��i�9b�Pg�����^����t����x��)O��Q�My95�G���;w9�n��$�z[������<w�#�)+��"������" U~}����O��[��|��]q;�lzt�;��Ȱ:��7�������E��*��oh�z���N<_�>���>>��|O�׷_L��/������զ9̳���{���z~����Ŀ?� �.݌��?�N����|��ZgO�o�����9��!�
Ƽ�}S߫˓���:����q�;i��i�]�t� G��Q0�_î!�w��?-��0_�|��nk�S�0l�>=]�e9�G��v��J[=Y9b�3�mE�X�X�-A��fV�2K�jS0"��2!��7��؀�3���3�\�+2�Z`��T	�hI-��N�2���A��M�@�jl����	���5�a�Y�6-o���������x}�}t��Zgs>1)���mQ?����vbZR����m���C��C�{�3o��=}b"/�|���o��?_^�_�+��,���5�U��� 4��]>	@Cl5���w��_$�c��V��sr*5 5��I��9��
�hJV�!�jk�A�=ٞ7���9<T�gť�o�٣����������l��Y�:���}�G�R}Ο����������r!Nϊ�C�;m7�dg����Ez���S%��8��)2Kͪ�6̰�5�/Ӥ�ag�1���,9Pu�]o�Q��{��;�J?<�Yo^_��~��.�>�����]����>߿Y�_�,�U_��o�~��[?n�=��Wg����>���������}y��N�m	n���Kro�䨯rJ���.u�e���-K��䐖��Y�['��N��p������r�Εܪ�x]���j1=^�wʩ4�,���!�&;ج��j�e��EcL���b�_��E�ϕ�u�$�Y��Lj��*���٢Z�y�F��m�p�
�Rw�����,Y�/q��h�M!���,V� �g��Y�J��
.��e�h#�m�d���Y�h�������k�c�q��ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[  m�%�/?�w[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://b3hrp63bn2o45"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 ��	��i����mu��[remap]

path="res://.godot/exported/133200997/export-fed5773a2d36fbc818b032cc3cddbb98-AIPaddle.scn"
N��̬�i�z�[remap]

path="res://.godot/exported/133200997/export-9e50f8f041ee32305e0343a759165653-Ball.scn"
`?~�k���聟>[remap]

path="res://.godot/exported/133200997/export-7adf28ae5f4f56274d5082ddbc459574-Ball_Ghost.scn"
d�37��ť	[remap]

path="res://.godot/exported/133200997/export-ebc741d9ca7bc58bf3f4d09c000e7715-Main.scn"
v�^���ľ�����[remap]

path="res://.godot/exported/133200997/export-226510183ac18e76d59f98c279838799-GameHUD.scn"
���)1���j([remap]

path="res://.godot/exported/133200997/export-dc5659603021f6123da542ea8bcad841-MainMenu.scn"
�koc�u�(L6[remap]

path="res://.godot/exported/133200997/export-9a4cbcec44ad0903bb765ad03b95706c-PauseMenu.scn"
u��D���� [remap]

path="res://.godot/exported/133200997/export-42c4e1b2659fa5596d4388773675d19a-SettingsMenu.scn"
zO�����[remap]

path="res://.godot/exported/133200997/export-418aa4b5b5277b4fa9106e13595f1556-PlayerPaddle.scn"
�ie.j	list=Array[Dictionary]([])
��^̉<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
�S=CҺ�   Q�$�Oh   res://AIPaddle/AIPaddle.tscn��9�-�5   res://Ball/Ball.tscn�����(�z   res://Debugging/Ball_Ghost.tscnʙ��" E   res://Main/Main.tscnόU�2V$   res://PlayerPaddle/PlayerPaddle.tscn�.�{�<   res://icon.svgpO�[p   res://Menus/MainMenu.tscnpO�[p"   res://Menus/MainMenu/MainMenu.tscnNB��	+D   res://Menus/Pause/Pause.tscnNB��	+D    res://Menus/Pause/PauseMenu.tscni}�D��:B    res://Menus/GameHUD/GameHUD.tscn��}\�P"   res://Menus/Settings/Settings.tscn��}\�P&   res://Menus/Settings/SettingsMenu.tscn)6�������ECFG      application/config/name         HardcorePong   application/run/main_scene,      "   res://Menus/MainMenu/MainMenu.tscn     application/config/features$   "         4.1    Forward Plus        application/boot_splash/bg_color                    �?   application/config/icon         res://icon.svg     autoload/Settings(         *res://Singletons/Settings.gd   "   display/window/size/viewport_width         #   display/window/size/viewport_height      �     display/window/stretch/mode         viewport   display/window/vsync/vsync_mode          
   input/down0              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         input/up0              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         input/pause�              events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script            deadzone      ?2   rendering/environment/defaults/default_clear_color                    �?�ѱ�¨m5)^v