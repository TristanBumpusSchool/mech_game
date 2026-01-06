extends CharacterBody3D

@export var speed = 0.0
@export var max_speed = 10.0
@export var accel = 1.0
@export var jump_time = 1.0
@export var jump_speed = 5.0
@export var cam_sensativity = 30000
@export var jumping = false
@export var target = Vector3.ZERO
@export var hp = 300



func damaged(d):
	hp -= d

func cam_rotation():
	var temp = rotation.y
	temp += -Input.get_last_mouse_screen_velocity().x / cam_sensativity
	
	var temp_2 = $SpringArm3D.rotation.x
	temp_2 += -Input.get_last_mouse_screen_velocity().y / cam_sensativity
	
	rotation = Vector3(0,temp,0)
	
	$SpringArm3D.rotation = Vector3(temp_2,0,0)
	
	$SpringArm3D.rotation.x = clamp($SpringArm3D.rotation.x, -1, .72)
	
	#$SpringArm3D.rotate(Input.get_last_mouse_screen_velocity())

func movement():
	var direction =  Vector2.ZERO
	if(Input.is_action_pressed("w")):
		direction +=  Vector2($front.global_position.x, $front.global_position.z) - Vector2(global_position.x, global_position.z)
	if(Input.is_action_pressed("s")):
		direction +=  Vector2(global_position.x, global_position.z) - Vector2($front.global_position.x, $front.global_position.z)
	
	if(Input.is_action_pressed("a")):
		direction += Vector2(global_position.x, global_position.z) - Vector2($left.global_position.x, $left.global_position.z) 
	if(Input.is_action_pressed("d")):
		direction += Vector2(global_position.x, global_position.z) - Vector2($right.global_position.x, $right.global_position.z) 
	
	direction = direction.normalized()
	
	var temp_speed = max_speed
	
	if Input.is_action_pressed("shift"):
		temp_speed *= 2
	
	
	if temp_speed > speed:
		speed += accel
	else:
		speed = temp_speed
	
	if direction == Vector2.ZERO:
		speed = 0
	
	velocity = Vector3(direction.x * speed, 0, direction.y * speed)
	
	if Input.is_action_just_pressed("space") and is_on_floor():
		jumping = true
		$timers/jump_timer.start(jump_time)
	
	if Input.is_action_just_released("space"):
		jumping = false
		$timers/jump_timer.stop()
	
	
	if jumping:
		velocity.y += jump_speed
	
	if !is_on_floor() and !jumping:
		velocity.y += -10

func attack():
	if $joint2/placement/arm != null:
		#region Left arm range type
		if $joint2/placement/arm.type == 1:
			if Input.is_action_just_pressed("click"):
				var left_arm = create_tween()
				left_arm.tween_property($joint2,"rotation_degrees",Vector3(0,0,0), .2)
				left_arm.tween_property($joint2/placement/arm,"firering",true, .2)
			if Input.is_action_pressed("click"):
				if $SpringArm3D/Camera3D/RayCast3D.is_colliding():
					$joint2.look_at($SpringArm3D/Camera3D/RayCast3D.get_collision_point())
				else:
					$joint2.rotation_degrees = Vector3(0,0,0)
			else:
				$joint2/placement/arm.firering = false
			if Input.is_action_just_released("click"):
				$joint2/placement/arm.firering = false
				var left_arm = create_tween()
				left_arm.tween_property($joint2,"rotation_degrees",Vector3(-45,0,0), .2)
			#endregion
		#region Left arm melee type
		if $joint2/placement/arm.type == 0:
			if Input.is_action_just_pressed("click"):
				var left_arm = create_tween()
				left_arm.tween_property($joint2,"rotation_degrees",Vector3(45,0,0), .3)
				left_arm.tween_property($joint2,"rotation_degrees",Vector3(-45,0,0), .1)
				left_arm.tween_property($joint2,"rotation_degrees",Vector3(0,90,0), .2)
			#endregion
	if $joint/placement/arm != null:
		#region Right arm range type
		if $joint/placement/arm.type == 1:
			if Input.is_action_just_pressed("r_click"):
				var right_arm = create_tween()
				right_arm.tween_property($joint,"rotation_degrees",Vector3(0,0,0), .2)
				right_arm.tween_property($joint/placement/arm,"firering",true, .2)
			if Input.is_action_pressed("r_click"):
				if $SpringArm3D/Camera3D/RayCast3D.is_colliding():
					$joint.look_at($SpringArm3D/Camera3D/RayCast3D.get_collision_point())
				else:
					$joint.rotation_degrees = Vector3(0,0,0)
			else:
				$joint/placement/arm.firering = false
			if Input.is_action_just_released("r_click"):
				$joint/placement/arm.firering = false
				var right_arm = create_tween()
				right_arm.tween_property($joint,"rotation_degrees",Vector3(-45,0,0), .2)
			#endregion
		#region Right arm range type
		if $joint/placement/arm.type == 0:
			if Input.is_action_just_pressed("r_click"):
				var right_arm = create_tween()
				right_arm.tween_property($joint,"rotation_degrees",Vector3(45,0,0), .3)
				right_arm.tween_property($joint,"rotation_degrees",Vector3(-45,0,0), .1)
				right_arm.tween_property($joint,"rotation_degrees",Vector3(0,-90,0), .2)
			#endregion



func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$joint/placement/arm.add_to_group("p")
	$joint2/placement/arm.add_to_group("p")
	$joint/placement/arm.shooter = "p"
	$joint2/placement/arm.shooter = "p"



func _process(delta: float) -> void:
	
	#debug exit im tired of escape and moving my mouse
	if Input.is_action_just_pressed("debug_quit"):
		get_tree().quit()
	if $SpringArm3D/Camera3D/RayCast3D.is_colliding():
		target = $SpringArm3D/Camera3D/RayCast3D.get_collision_point()
	else:
		target = Vector3.ZERO
	
	cam_rotation()
	movement()
	attack()
	
	move_and_slide()



func _on_jump_timer_timeout() -> void:
	jumping = false
