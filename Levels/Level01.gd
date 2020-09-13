extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body is MainCharacter:
		get_tree().paused = true
		$WinUI.show()
	pass # Replace with function body.

func _on_TouchScreenButton_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
	pass # Replace with function body.


func _on_TouchScreenButton2_pressed():
	get_tree().quit()
	pass # Replace with function body.
