extends Area


var locked = true

func _ready():
	$Light.light_color = Color(1, 0, 0, 1)

func unlock():
	$Light.light_color = Color(0, 1, 0, 1)
	locked = false


func _on_Exit_body_entered(body):
	if body.name == "Player" and not locked:
		queue_free()
		
