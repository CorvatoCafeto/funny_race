extends Spatial

func _on_Area_body_entered(body):
	if body is MainCharacter:
		get_tree().paused = true
		$WinUI.show()

func _on_TouchScreenButton_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_TouchScreenButton2_pressed():
	get_tree().quit()

