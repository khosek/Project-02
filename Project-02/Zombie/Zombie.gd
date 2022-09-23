extends KinematicBody2D

var velocity = Vector2.ZERO

var acceleration = 5.0
var max_speed = 800.0
var health = 100

var player = null

func _ready():
	scale = Vector2(0,0)


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.damage(1)

func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(100)
		queue_free()

func _physics_process(_delta):
	if scale.x < 1:
		scale.x += 0.01
		scale.y += 0.01
	var direction = Vector2.ZERO
	player = get_node_or_null("/root/Game/Player_Container/Player")
	if player != null:
		var rot = global_position.angle_to_point(player.global_position) + PI
		self.rotation = rot
		direction = Vector2(0,1).rotated(rot - PI/2)
	velocity += direction * acceleration
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	velocity = move_and_slide(velocity, Vector2.ZERO)
