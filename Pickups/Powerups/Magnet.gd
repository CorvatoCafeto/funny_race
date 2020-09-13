extends Area

func _on_Magnet_body_entered(body):
	if body is MainCharacter:
		(body as MainCharacter).set_magnet_on()
		queue_free()
