extends Control
onready var game = null

func _ready():
	var _connect = get_tree().connect("network_peer_connected", self, "_player_connected")


func _on_Host_pressed():
	var net = NetworkedMultiplayerENet.new()
	net.create_server(13458, 4095)
	get_tree().set_network_peer(net)
	Global.which_player = 1
	print("hosting")

func _on_Join_pressed():
	var net = NetworkedMultiplayerENet.new()
	net.create_client("127.0.0.1", 13458)
	get_tree().set_network_peer(net)
	Global.which_player = 2

func _player_connected(id):
	Global.player2id = id
	if game == null:
		game = get_node_or_null("res://Game.tscn")
	else:
		game.instance()
		get_tree().get_root().add_child(game)
		hide()
