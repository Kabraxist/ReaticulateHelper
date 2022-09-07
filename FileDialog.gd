extends FileDialog

func _ready():
	pass # Replace with function body.


func _on_FileDialog_file_selected(path):
	var file = File.new()
	file.open(path, File.WRITE)
	var savetext = $"../Base/HBoxContainer/L/VBoxContainer/TextExport".text
	file.store_string(savetext)	
	file.close()

func _on_ExportButton_pressed():
	self.popup()
