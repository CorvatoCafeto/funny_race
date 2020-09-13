extends RigidBody

func _on_Area_body_entered(body):
	if body is MainCharacter:
		body.add_point()
		queue_free()
	pass
