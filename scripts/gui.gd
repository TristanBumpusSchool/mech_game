extends Control

@export var player = CharacterBody3D
var start = true


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	$score.text = str(global.score)
	
	if start:
		$hp_bar/arm_1.max_value = $"../joint/placement".get_child(0).hp
		$hp_bar/arm_2.max_value = $"../joint2/placement".get_child(0).hp
		$hp_bar/leg_1.max_value = player.hp
		$hp_bar/leg_2.max_value = player.hp
		$hp_bar/joint_1.max_value = $"../joint".hp
		$hp_bar/joint_2.max_value = $"../joint2".hp
		$hp_bar/body.max_value = player.hp
		start = false
	
	for i in $hp_bar.get_children():
		if i.value < i.max_value * .5:
			i.tint_progress = Color(0.73, 0.73, 0.0, 1.0)
		if i.value < i.max_value * .1:
			i.tint_progress = Color(0.66, 0.0, 0.0, 1.0)
	
	if $"../joint/placement".get_child(0) != null:
		$hp_bar/arm_1.value = $"../joint/placement".get_child(0).hp
	elif $hp_bar/arm_1 != null:
		$hp_bar/arm_1.queue_free()
	
	if $"../joint2/placement".get_child(0) != null:
		$hp_bar/arm_2.value = $"../joint2/placement".get_child(0).hp
	elif $hp_bar/arm_2 != null:
		$hp_bar/arm_2.queue_free()
	
	$hp_bar/leg_1.max_value = player.hp
	$hp_bar/leg_2.max_value = player.hp
	
	if $"../joint" != null:
		$hp_bar/joint_1.value = $"../joint".hp
	elif $hp_bar/joint_1 != null:
		$hp_bar/joint_1.queue_free()
	if $"../joint2" != null:
		$hp_bar/joint_2.value = $"../joint2".hp
	elif $joint_2 != null:
		$hp_bar/joint_2.queue_free()
	
	$hp_bar/body.value = player.hp
