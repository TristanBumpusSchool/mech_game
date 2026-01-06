extends Node3D


func _on_timer_timeout() -> void:
	var to_spawn = ["res://entities/building/car_obj.tscn","res://entities/enemies/alien_npc.tscn"]
	
	var spawn = load(to_spawn.pick_random()).instantiate()
	
	var path = get_children().pick_random()
	
	var point = randi_range(0, path.curve.get_point_count() - 1)
	
	spawn.global_position = path.curve.get_point_position(point)
	
	path.add_child(spawn)
