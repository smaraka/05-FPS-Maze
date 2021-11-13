extends Spatial


func _ready():
	hide()
	
func _on_Timer_timeout():
	hide()

func shoot():
	show()
	$Timer.start()
