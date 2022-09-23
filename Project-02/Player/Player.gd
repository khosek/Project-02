extends KinematicBody2D

var velocity = Vector2.ZERO

#var rotation_speed = 5.0
var speed = 20.0
var max_speed = 200.0
var health = 5

var Effects = null
onready var Explosion = load("res://Effects/Explosion.tscn")

onready var Bullet = load("res://Player/Bullet.tscn")
var nose = Vector2(10,-25)

var target_pos = Vector2(Global.VP.x / 2, Global.VP.y / 2)

var invincible = false
var invincible_cycles = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		target_pos += event.relative / 2

func _physics_process(_delta):
	velocity = velocity + get_input()*speed
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	velocity = move_and_slide(velocity, Vector2.ZERO)
#	position.x = wrapf(position.x, 0, Global.VP.x)
#	position.y = wrapf(position.y, 0, Global.VP.y)
	
	target_pos += get_input() * 3.2
	$Crosshair.global_position = target_pos
#	$Crosshair.global_position.y -= 12
#	$Crosshair.global_position.x += 12
	var rot = global_position.angle_to_point(target_pos) - PI / 2
	self.rotation = rot
	$Crosshair.rotation = -rot
	
	if Input.is_action_just_pressed("shoot"):
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var bullet = Bullet.instance()
			bullet.global_position = global_position + nose.rotated(rotation)
			bullet.rotation = (global_position + nose.rotated(rotation)).angle_to_point(target_pos) - PI / 2
			Effects.add_child(bullet)

func get_input():
	var to_return = Vector2.ZERO
	if Input.is_action_pressed("up"):
		to_return.y -= 1
	if Input.is_action_pressed("down"):
		to_return.y += 1
	if Input.is_action_pressed("left"):
		to_return.x -= 1
	if Input.is_action_pressed("right"):
		to_return.x += 1
	# If the player isn't pressing any buttons, apply a counter-force
	if to_return == Vector2.ZERO:
		velocity /= 1.5
	return to_return
	
func damage(d):
	if not invincible:
		health -= d
		Global.update_health(-d)
		if health <= 0:
			Effects = get_node_or_null("/root/Game/Effects")
			if Effects != null:
				var explosion = Explosion.instance()
				Effects.add_child(explosion)
				explosion.global_position = global_position
				hide()
				yield(explosion, "animation_finished")
			queue_free()
		# give the player i-frames
		invincible = true
		$Timer.start(0.25)
		$Sprite.hide()


func _on_Area2D_body_entered(body):
	if body.name != "Player" and body.name != "Bounds":
		damage(1)


func _on_Timer_timeout():
	# flicker visibility and invisibility
	if $Sprite.visible:
		$Sprite.hide()
	else:
		$Sprite.show()
	invincible_cycles += 1
	if invincible_cycles >= 10:
		# remove the player's i-frames
		invincible = false
		invincible_cycles = 0
		$Sprite.show()
	else:
		$Timer.start(0.25)
