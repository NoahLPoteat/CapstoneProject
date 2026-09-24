extends Control

@onready var pan1: TextureRect = $MovePanelUp1
@onready var pan2: TextureRect = $MovePanelUp2
@onready var pan3: TextureRect = $MovePanelUp3
func update(in_num: int):
	match in_num:
		0:
			pan1.visible = false
			pan2.visible = false
			pan3.visible = false
			return
		1:
			pan1.visible = true
			pan2.visible = false
			pan3.visible = false
			return
		2:
			pan1.visible = true
			pan2.visible = true
			pan3.visible = false
			return
		_:
			pan1.visible = true
			pan2.visible = true
			pan3.visible = true
			return
