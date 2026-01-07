extends Node

var left = 0
var right = 0

var arms = ["res://entities/player/arm_1.tscn","res://entities/arms/arm_4.tscn","res://entities/arms/arm_3.tscn","res://entities/player/arm_2.tscn"]

var score = 0

var menu_music_location = 0

func sfx(sound = "", pos = Vector3.ZERO):
	var s = load("res://sfx.tscn").instantiate()
	
	s.global_position = pos
	s.sound = sound
	get_tree().current_scene.add_child(s)

func pop_up(text : String, pos : Vector3, col : Color):
	var pop = load("res://entities/pop_up.tscn").instantiate()
	pop.global_position = pos + Vector3(randf_range(-1,1), 4,randf_range(-1,1))
	pop.t = text
	pop.color = col
	get_tree().current_scene.add_child(pop)
