extends Node2D

onready var Zombie = load("res://Zombie/Zombie.tscn")

func _ready():
	$Timer.start(3)

func _on_Timer_timeout():
	var zombie = Zombie.instance()
	# randomizing zombie position
	zombie.position = Vector2(Global.VP.x / 2, Global.VP.y / 2)
	var rand_position = 4 * randf()
	if rand_position > 3:
		zombie.position.y += 267 #North spawn
	elif rand_position > 2:
		zombie.position.x += 480 #East spawn
	elif rand_position > 1:
		zombie.position.y -= 267 #South spawn
	else:
		zombie.position.x -= 480 #West spawn
#	zombie.player = get_node_or_null("Player_Container/Player")
	add_child(zombie)
#	print(zombie.player)
	$Timer.start($Timer.wait_time * .99)
#	print($Timer.time_left)
