extends Area

var parent_rotation

func _ready():
	parent_rotation = get_parent().rotation
	pass

func _on_Area_body_entered(body):
	if body is MainCharacter:
		#body.global_rotate(Vector3(0,1,0), parent_rotation.y) 
		
		#body.rotation = Vector3(body.rotation.x,rotation.y, body.rotation.z)
		#body.look_at(self.position)
		body.rotation_degrees.y +=45
	pass 
