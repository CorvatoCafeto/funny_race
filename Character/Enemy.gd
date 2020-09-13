extends KinematicBody

class_name EnemyAI

export var min_reaction_time : float = 1.0
export var max_reaction_time : float = 2.0
export var reaction_margin : float = 0.5

export var min_wait_time : float = 0.5
export var max_wait_time : float = 1.0

export var velocity: Vector3 = Vector3()
onready var state_machine: AnimationTree = get_node("AnimationTree")

var obstacles_visited = []

var can_move = false

func _ready():
	set_axis_lock(1, true)
	pass 
	
func _process(_delta):
	if can_move:
		var _movement = move_and_slide(velocity, global_transform.basis.z)
		state_machine.set("parameters/Moving/blend_position", Vector2(velocity.x,velocity.z).length())
	pass
	
func _on_ObstacleCheck_body_entered(body):
	
	var rng = RandomNumberGenerator.new()
		
	if !(body in obstacles_visited):		
		rng.randomize()
		var reaction_time = rng.randf_range(min_reaction_time, max_reaction_time)
		
		if reaction_time < (max_reaction_time - reaction_margin):
			#print(reaction_time)		
			velocity = Vector3.ZERO
			state_machine.set("parameters/Moving/blend_position", Vector3.ZERO)
			obstacles_visited.append(body)
			$Wait.wait_time = reaction_time
			$Wait.start()
	pass

func _on_Wait_timeout():	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$Continue.wait_time = rng.randf_range(min_wait_time, max_wait_time)
	$Continue.start()
	pass 

func _on_Continue_timeout():	
	velocity = Vector3(0,0,-8)
	pass 

var last_checkpoint_visited

func _on_DeathCheck_area_entered(area):
	obstacles_visited.clear()	
	translation.z = last_checkpoint_visited

func _on_Checkpoint_area_entered(area):
	last_checkpoint_visited = (area as Area).translation.z


func _on_MatchStart_timeout():
	can_move = true
	pass # Replace with function body.


func _on_ObstacleCheck_area_entered(area):
	var rng = RandomNumberGenerator.new()
		
	if !(area in obstacles_visited):		
		rng.randomize()
		var reaction_time = rng.randf_range(min_reaction_time, max_reaction_time)
		
		if reaction_time < (max_reaction_time - reaction_margin):
			#print(reaction_time)		
			velocity = Vector3.ZERO
			state_machine.set("parameters/Moving/blend_position", Vector3.ZERO)
			obstacles_visited.append(area)
			$Wait.wait_time = reaction_time
			$Wait.start()
	pass

