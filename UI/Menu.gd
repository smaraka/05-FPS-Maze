extends Control

func _physics_process(_delta):
	if get_tree().paused == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_Restart_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Maze/Maze.tscn")

func _on_Quit_pressed():
	get_tree().quit()
