extends Timer

func _process(delta):
	($Control/Label as Label).text = int(time_left) as String 
	pass

func _on_MatchStart_timeout():
	$Control.hide()
	pass 
