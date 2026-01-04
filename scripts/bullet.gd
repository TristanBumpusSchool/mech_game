extends CharacterBody3D

@export var damage = 1
@export var speed = 100
@export var target = Vector3.ZERO


func _process(delta: float) -> void:
	
	velocity = target * speed
	velocity.y += -1
	
	move_and_slide()



func _on_area_3d_body_entered(body: Node3D) -> void:
	queue_free()


func _on_death_time_timeout() -> void:
	queue_free()
