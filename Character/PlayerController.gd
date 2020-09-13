extends KinematicBody

class_name MainCharacter

var velocity: Vector3 = Vector3(0,0,8)

export var speed = 8

var touching: bool

onready var state_machine: AnimationTree = get_node("AnimationTree")

var score = 0

var has_shield = false

var can_move = false

func _ready():
	pass 

func _physics_process(_delta):
	if touching and can_move:
		velocity = move_and_slide(transform.basis.z * speed)

func _input(event):		
	if event is InputEventScreenTouch and event.is_pressed():
		touching = true
		state_machine.set("parameters/Moving/blend_position", Vector2(velocity.x,velocity.z).length())	
	elif !event.is_pressed():
		touching = false
		state_machine.set("parameters/Moving/blend_position", velocity)
			
func add_point():
	score = score + 1
	update_score_ui()
	
func update_score_ui():
	var label: Label = $SpringArm/Camera/Score.get_child(0)
	label.text = score as String

var last_checkpoint_visited

func _on_DeathCheck_area_entered(area):
	if !has_shield and area.collision_layer == 4:
		translation.z = last_checkpoint_visited
	else:
		has_shield = false
		$Shield.hide()
		$SpringArm/Camera/Score.get_child(1).hide()

func _on_Checkpoint_area_entered(area):
	last_checkpoint_visited = (area as Area).translation.z
	
func set_shield_on():
	has_shield = true
	$Shield.show()
	$SpringArm/Camera/Score.get_child(1).show()
	
func set_magnet_on():
	$MagnetArea/CollisionShape.disabled = false
	$SpringArm/Camera/Score.get_child(2).show()
	$Timer.start(4)
	pass

func _on_Timer_timeout():
	$MagnetArea/CollisionShape.disabled = true
	$SpringArm/Camera/Score.get_child(2).hide()
	pass

func _on_MatchStart_timeout():
	can_move = true
	pass 
