extends Control


func _ready():
	hide()

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		if not visible:
			get_tree().paused = true
			show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			get_tree().paused = false
			hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_Restart_pressed():
	get_tree().paused = false
	Global._reset()
	var _scene = get_tree().change_scene("res://Game.tscn")


func _on_Quit_pressed():
	get_tree().quit()
