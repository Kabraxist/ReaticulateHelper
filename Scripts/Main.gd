extends Control

const ArticulationPrefabPreload = preload("res://Prefabs/Articulation.tscn")

onready var ArtcPrefab = ArticulationPrefabPreload
onready var TextExport = get_node("Base/HBoxContainer/L/VBoxContainer/TextExport")
onready var ArtList  = get_node("Base/HBoxContainer/R/VBoxContainer/ScrollContainer/ArtList")

func _on_CopyButton_button_down():
	OS.set_clipboard(TextExport.text)
	
func _on_AddNewBut_button_down():
	ArtList.add_child(ArtcPrefab.instance())
	
func _on_DuplicateBut_button_down():
	if(ArtList.get_child_count() > 0):
		var _dupArt = ArtcPrefab.instance()
		ArtList.add_child(_dupArt)
		var _prevArt = ArtList.get_child(ArtList.get_child_count() - 2)
	
		_dupArt.get_child(0).text = _prevArt.get_child(0).text
		_dupArt.get_child(1).text = _prevArt.get_child(1).text
		_dupArt.get_child(2).selected = _prevArt.get_child(2).selected
		_dupArt.get_child(3).text = _prevArt.get_child(3).text
		_dupArt.get_child(4).text = _prevArt.get_child(4).text
	else:
		print_debug("Nothing to duplicate")
	
func _on_GenerateBut_button_down():
	TextExport.text = ""
	var ArtArray = ArtList.get_children()
	
	var BankName = get_node("Base/HBoxContainer/R/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer3/GroupName").text
	var GroupName = get_node("Base/HBoxContainer/R/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer3/BankName").text
	
	TextExport.text += "//! g=\"%s\" n=\"%s\"\n" % [BankName, GroupName]
	TextExport.text += "Bank * * %s\n" % [GroupName]
	
	for Art in ArtArray:
		var _a = Art.get_child(0).text
		var _b = Art.get_child(1).text
		var _c = Art.get_child(2).text.to_lower()
		var _d = Art.get_child(3).text
		var _e = Art.get_child(4).text
		
		var constructedLine = "//! c=%s i=%s o=%s\n%s %s\n" % [_c, _d, _e, _a, _b]
		
		TextExport.text += constructedLine

func _input(event):
	if event.is_action_pressed("rh_add_new"):
		_on_AddNewBut_button_down()
	
	if event.is_action_pressed("rh_duplicate"):
		_on_DuplicateBut_button_down()
		
	if event.is_action_pressed("rh_generate"):
		_on_GenerateBut_button_down()

