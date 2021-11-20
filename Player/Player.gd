extends KinematicBody

onready var Camera = $Pivot/Camera
onready var flash = $Pivot/Camera/Hand/Flash 

var damage = 10
const MAX_CAM_SHAKE = 0.4



var gravity = -30
var max_speed = 8
var score = 0
var mouse_sensitivity = 0.002
var mouse_range = 1.2

var velocity = Vector3()

#onready var anim_player = $AnimationPlayer
var anim_player = null
onready var camera = $Pivot/Camera
onready var raycast = $Pivot/Camera/RayCast
onready var decal = preload("res://decal/BulletDecal.tscn")

func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("forward"):
		input_dir += -Camera.global_transform.basis.z
	if Input.is_action_pressed("back"):
		input_dir += Camera.global_transform.basis.z
	if Input.is_action_pressed("left"):
		input_dir += -Camera.global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_dir += Camera.global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir

func fire():
	if anim_player == null:
		anim_player = get_node_or_null("AnimationPlayer")
	if anim_player != null:
		if Input.is_action_pressed("fire"):
			if not anim_player.is_playing():
				camera.translation = lerp(camera.translation, 
						Vector3(rand_range(MAX_CAM_SHAKE, -MAX_CAM_SHAKE), 
						rand_range(MAX_CAM_SHAKE, -MAX_CAM_SHAKE), 0), 0.5)
				if raycast.is_colliding():
					var target = raycast.get_collider()
					if target.is_in_group("Enemy"):
						score += 1
						target.queue_free()
			var d = decal.instance()
			raycast.get_collider().add_child(d)
			d.global_transform.origin= raycast.get_collision_point()
			d.look_at(raycast.get_collision_point() + raycast.get_collision_normal(), Vector3.UP)
			flash.shoot()
			anim_player.play("MazeAssaultFire")
			print(global_transform.origin)
		else:
			camera.translation = Vector3()
			anim_player.stop()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)

func _physics_process(delta):
	fire()
	
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP)


