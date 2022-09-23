extends Control


func _ready():
	$Label.text = "Thanks for playing! Your final score was " + str(Global.score) + "."
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Play_pressed():
	Global._reset()
	var _scene = get_tree().change_scene("res://Game.tscn")


func _on_Quit_pressed():
	get_tree().quit()
