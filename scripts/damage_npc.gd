extends CharacterBody3D


func damaged(d):
	$"../AnimationPlayer".play("death")

func death():
	global.score += 10
	queue_free()
