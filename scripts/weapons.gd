extends CharacterBody3D

@export_enum("melee weapon", "ranged weapon") var type
@export var firering = false
@export var fire = 0
@export var bullet = ""


func _process(delta: float) -> void:
	if type == 1:
		if firering:
			$AnimationPlayer.play("fire")
		if fire:
			var b = load(bullet)
			var bul = b.instantiate()
			bul.global_position = $bullet_source.global_position
			bul.rotation = rotation_degrees
			bul.target = ($bullet_source.global_position - global_position).normalized()
			get_tree().current_scene.add_child(bul)
			fire -= 1
