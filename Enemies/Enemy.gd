extends Spatial

enum {
	IDLE,
	ALERT
}

var state = IDLE

var target

const TURN_SPEED = 2

onready var Player = preload("res://Player/Player.tscn")

onready var raycast = $RayCast
onready var ap = $dummymale/AnimationPlayer
onready var eyes = $Eyes
onready var timer = $ShootTimer
var dummy = null



func _ready():
	pass

func _process(delta):
	var t = raycast.get_collider()
	if is_instance_valid(ap) and is_instance_valid(eyes) and is_instance_valid(t):
		if raycast.is_colliding():
			state = ALERT
		else:
			state = IDLE
			
		match state: 
			IDLE:
				ap.play("Idle")
			
			ALERT:
				ap.play("Alert")
				eyes.look_at(t.global_transform.origin, Vector3.UP)
				rotate_y(deg2rad(eyes.rotation.y * TURN_SPEED))


func _on_Sight_body_entered(body):
	if body.is_in_group("Player"):
		state = ALERT
		target = body
		timer.start()


func _on_Sight_body_exited(body):
	state = IDLE
	timer.stop()
	


func _on_ShootTimer_timeout():
	if raycast.is_colliding():
		var hit = raycast.get_collider()
		if hit.is_in_group("Player"):
			hit.queue_free()
			var player = Player.instance()
			add_to_group("Player")
			add_child(player)

			
