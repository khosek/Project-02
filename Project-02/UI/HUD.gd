extends Control


func _ready():
	Global.update_score(0)
	Global.update_health(0)
	Global.update_time(0)

func update_score():
	$Score.text = "Score: " + str(Global.score)

func update_health():
	$Lives.text = "Health: " + str(Global.health)

func update_time():
	$Time.text = "Time: " + str(Global.time)

func _on_Timer_timeout():
	Global.update_time(-1)

func move_HUD(VP):
	$Score.margin_right = VP.x
	$Time.margin_right = VP.x
	$Lives.margin_bottom = VP.y
	$Lives.margin_top = VP.y - 30
	$Lives.margin_right = VP.x
