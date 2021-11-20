extends Control


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func _on_Play_pressed():
	var _scene = get_tree().change_scene("res://Maze/Maze.tscn")


func _on_Quit_pressed():
	get_tree().quit()
