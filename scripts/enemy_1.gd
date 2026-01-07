extends CharacterBody3D

@onready var player = get_tree().get_first_node_in_group("p")
@export var hp = 300
@export var speed = 10.0
var has_range = false
var targets = []
var target = Vector3.ZERO
@onready var arms = []



func damaged(d):
	hp -= d
	
	global.pop_up(str(d),global_position, Color.RED)
	
	if hp <= 0:
		global.score += 150
		global.pop_up("+150",global_position, Color.YELLOW)
		$joint/placement.get_child(0).damaged(150)
		$joint2/placement.get_child(0).damaged(150)
		queue_free()



func _ready() -> void:
	
	$joint/placement.add_child(load(global.arms.pick_random()).instantiate())
	$joint2/placement.add_child(load(global.arms.pick_random()).instantiate())
	
	$joint/placement.get_child(0).add_to_group("e")
	$joint2/placement.get_child(0).add_to_group("e")
	$joint/placement.get_child(0).shooter = "e"
	$joint2/placement.get_child(0).shooter = "e"
	
	arms = [$joint2/placement.get_child(0), $joint/placement.get_child(0)]


func _process(delta: float) -> void:
	#if $joint/placement/arm.type == 1:
	$NavigationAgent3D.target_position = player.global_position
	
	
	has_range = false
	
	for i in arms:
		if i != null:
			if i.type == 1:
				has_range = true
		else:
			arms.remove_at(arms.find(i))
	
	for i in arms:
		if i != null:
			if i.type == 1:
				has_range = true
		else:
			arms.remove_at(arms.find(i))
	#Target check for null
	for i in targets:
		if i == null:
			targets.remove_at(targets.find(i))
	
	if targets.size():
		target = targets.pick_random().global_position
	
	if has_range:
		if targets.size():
			
			for i in arms:
				if i.type == 1:
					i.firering = true
		else:
			for i in arms:
				if i.type == 1:
					i.firering = false
		
		if $NavigationAgent3D.distance_to_target() >= 10:
			
			var walk_to = ($NavigationAgent3D.get_next_path_position() - global_position).normalized()
			
			velocity = walk_to * speed
			
			look_at(player.global_position)
			
			velocity.y = 0
		else:
			velocity = Vector3.ZERO
	elif !arms.is_empty():
		if $NavigationAgent3D.distance_to_target() >= 2:
			
			$AnimationPlayer.play("attack")
			
			var walk_to = ($NavigationAgent3D.get_next_path_position() - global_position).normalized()
			
			velocity = walk_to * speed
			
			look_at(player.global_position)
			
			velocity.y = 0
		else:
			velocity = Vector3.ZERO
	else:
		var walk_to = -($NavigationAgent3D.get_next_path_position() - global_position).normalized()
		
		velocity = walk_to * speed
		
		look_at(-player.global_position)
		
		velocity.y = 0
	
	move_and_slide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("p"):
		targets += [body]


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body != null:
		if targets.find(body) != -1:
			targets.remove_at(targets.find(body))
