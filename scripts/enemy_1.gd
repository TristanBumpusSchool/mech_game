extends CharacterBody3D

@onready var player = get_tree().get_first_node_in_group("p")
@export var hp = 300
@export var speed = 10.0
var has_range = false
var targets = []
var target = Vector3.ZERO
@onready var arms = [$joint2/placement/arm, $joint/placement/arm]



func damaged(d):
	hp -= d
	if hp <= 0:
		queue_free()



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
	
	if targets.size():
		target = targets.pick_random()
	
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
		targets += [body.global_position]
