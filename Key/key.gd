extends Area




func _on_key_body_entered(body):
	if body.name == "Player":
		var exit = get_node_or_null("/root/Game/Maze/Exit")
		if exit != null:
			exit.unlock()
			var _scene = get_tree().change_scene("res://UI/win.tscn")
			queue_free()
