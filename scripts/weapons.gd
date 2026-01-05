extends RigidBody3D

@export_enum("melee weapon", "ranged weapon","rag doll") var type
@export var firering = false
@export var fire = 0
@export var bullet = ""
@export var hp = 100
@export var damage = 100
@export var self_for_death = ""
@onready var target = get_parent().get_parent().get_parent()

var scrollpos:=0.0

func death_animation():
	if type != 2:
		var s = load(self_for_death).instantiate()
		
		s.global_position = global_position
		s.rotation = rotation
		s.sleeping = false
		s.gravity_scale = 1
		
		get_tree().current_scene.add_child(s)
	
	queue_free()

func damaged(d):
	hp -= d
	if hp <= 0:
		death_animation()



func _process(delta: float) -> void:
	control_range()
	if type == 1:
		if firering:
			$AnimationPlayer.play("fire")
		if fire:
			var b = load(bullet)
			var bul = b.instantiate()
			bul.global_position = $bullet_source.global_position
			if target.target == Vector3.ZERO:
				bul.target = ($bullet_target.global_position - $bullet_source.global_position).normalized()
			else:
				bul.target = (target.target - $bullet_source.global_position).normalized()
			
			get_tree().current_scene.add_child(bul)
			fire -= 1




func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("damaged"):
		body.damaged(damage)

func control_range():
	#changes scale of the sprite therefore trajectory
	if Input.is_action_just_released("scroll_down"):
		scrollpos-=0.5
	if Input.is_action_just_released("scroll_up"):
		scrollpos+=0.5
	scrollpos = clampf(scrollpos,1.0,20.0)
	if $trajectory!=null:
		$trajectory.scale.x=scrollpos
	#$trajectory.scale.x=scrollpos
	
