extends CharacterBody3D


func damaged(d):
	global.pop_up("+10",global_position, Color.YELLOW)
	$"../AnimationPlayer".play("death")

func death():
	global.score += 10
	queue_free()
