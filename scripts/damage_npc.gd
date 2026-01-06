extends CharacterBody3D


func damaged(d):
	$"../AnimationPlayer".play("death")

func death():
	queue_free()
