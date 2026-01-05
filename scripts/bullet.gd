extends CharacterBody3D

@export var damage = 1
@export var speed = 100
@export var target = Vector3.ZERO
@export var explosion = ""


func _process(delta: float) -> void:
	
	
	velocity = target * speed
	velocity.y += -1
	
	look_at(target + global_position)
	move_and_slide()



func _on_area_3d_body_entered(body: Node3D) -> void:
	if explosion != "":
		var boom = load(explosion).instantiate()
		boom.global_position = global_position
		boom.target = global_position
		boom.speed = 0
		get_tree().current_scene.add_child(boom)
	if speed != 0:
		queue_free()
	if body.has_method("damaged"):
		body.damaged(damage)
		


func _on_death_time_timeout() -> void:
	queue_free()
