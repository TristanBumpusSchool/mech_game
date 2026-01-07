extends Node3D


func _on_timer_timeout() -> void:
	var e = load("res://entities/enemies/enemy_1.tscn").instantiate()
	
	e.global_position = Vector3(randi_range(-100, 100),2.5, randi_range(-100, 100))
	
	get_tree().current_scene.add_child(e)
