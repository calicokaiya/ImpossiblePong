extends Control

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

