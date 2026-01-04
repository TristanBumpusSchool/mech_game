extends CharacterBody3D

@export_enum("melee weapon", "ranged weapon") var type
@export var firering = false
@export var fire = 0
@export var bullet = ""
@export var hp = 100
@export var damage = 100
@onready var target = get_parent().get_parent().get_parent()


func damaged(d):
	hp -= d
	if hp <= 0:
		queue_free()



func _process(delta: float) -> void:
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
