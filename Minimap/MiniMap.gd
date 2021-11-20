extends Node2D

var Player = null

func _physics_process(_delta):
		if Player == null:
			Player = get_node_or_null("/root/Game/Player")
		if Player != null:
			if is_instance_valid(Player):
				var p = Player.global_transform.origin
				position = (Vector2(p.x, p.z) * -8) + Vector2(-2.5, -2.5)
				get_parent().rotation_degrees = Player.rotation_degrees.y
