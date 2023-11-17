extends Control


# Called when the node enters the scene tree for the first time.
var caseScene = preload("res://case.tscn")
var height = 11
var length = 11
var origin = 5

var XYdelimiter = ","
var caseDelimiter = "," 

var allSelectedCases = []

func _ready():
	
	for x in range(0, length):
		var column = VBoxContainer.new()
		column.add_theme_constant_override("separation", 1)
		column.name = str(x-5)
		column.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		column.size_flags_vertical = Control.SIZE_EXPAND_FILL
		$VBoxContainer/FieldContainer.add_child(column)
		
		for j in range(0, height):
			var case = caseScene.instantiate()
			case.name = str((j-5)*-1)
			case.fullPos = '['+column.name+XYdelimiter+case.name+']'
			case.connect("selected", self.on_selected_received)
			column.add_child(case)


func on_selected_received(name):
	if name in allSelectedCases:
		allSelectedCases.erase(name)
	else:
		allSelectedCases.append(name)

	var printableList = '{"cases":['
	
	for case in allSelectedCases:
		printableList += str(case)
		printableList += caseDelimiter
	
	printableList[-1] = ']'
	printableList += '}'
	
	$VBoxContainer/HBoxContainer/CasesLabel.text = printableList


func _on_button_pressed():
	DisplayServer.clipboard_set($VBoxContainer/HBoxContainer/CasesLabel.text)
