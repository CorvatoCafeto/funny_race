extends Area

func _on_Shield_body_entered(body):
	if body is MainCharacter:
		(body as MainCharacter).set_shield_on()
		queue_free()
