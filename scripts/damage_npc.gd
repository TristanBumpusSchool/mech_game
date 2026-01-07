extends CharacterBody3D


func damaged(d):
	global.sfx("res://assets/sound/explosion.wav", global_position, -10)
	$CollisionShape3D.queue_free()
	print($CollisionShape3D.disabled)
	global.pop_up("+10",global_position, Color.YELLOW)
	global.score += 10
	$"../AnimationPlayer".play("death")

func death():
	queue_free()
