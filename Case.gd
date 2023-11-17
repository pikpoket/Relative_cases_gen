extends TextureButton

var fullPos = null
signal selected(name)

func _ready():
	$Label.text = str(fullPos)
	
func _on_toggled(button_pressed):
	if button_pressed == true:
		modulate = Color.BLUE
	else:
		modulate = Color(1,1,1,1)
	print("selected "+str(fullPos))
	emit_signal("selected", fullPos)
