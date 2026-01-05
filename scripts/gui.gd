extends Control

@export var player = CharacterBody3D



func _ready() -> void:
	$arm_1.max_value = $"../joint/placement/arm".hp
	$arm_2.max_value = $"../joint2/placement/arm".hp
	#$leg_1.max_value
	#$leg_2.max_value
	$joint_1.max_value = $"../joint".hp
	$joint_2.max_value = $"../joint2".hp
	$body.max_value = player.hp

func _process(delta: float) -> void:
	if $"../joint/placement/arm" != null:
		$arm_1.value = $"../joint/placement/arm".hp
	elif $arm_1 != null:
		$arm_1.queue_free()
	
	if $"../joint2/placement/arm" != null:
		$arm_2.value = $"../joint2/placement/arm".hp
	elif $arm_2 != null:
		$arm_2.queue_free()
	#$leg_1.max_value
	#$leg_2.max_value
	
	if $"../joint" != null:
		$joint_1.value = $"../joint".hp
	elif $joint_1 != null:
		$joint_1.queue_free()
	if $"../joint2" != null:
		$joint_2.value = $"../joint2".hp
	elif $joint_2 != null:
		$joint_2.queue_free()
	$body.value = player.hp
