extends Control

@onready var portrait_gui: TextureRect = $Portrait

func update_gui(new_char: UnitBase):
	portrait_gui.texture = new_char.portrait_texture
