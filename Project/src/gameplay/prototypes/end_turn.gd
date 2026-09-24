extends Control
signal end_turn_button_pressed()

@onready var end_up: TextureRect = $EndUp

var pressed: bool = false

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if not pressed:
			end_up.visible = false
			end_turn_button_pressed.emit()
			pressed = true
		else:
			end_up.visible = true
			pressed = false


func _on_area_2d_mouse_exited() -> void:
	end_up.visible = true
	pressed = false
