extends PathFollow3D

@export var dead = false


func damaged(d):
	$AnimationPlayer.play("death")


func _process(delta: float) -> void:
	
	if !dead:
		progress_ratio += .0001
	
	#look_at()
