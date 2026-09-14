class_name MapNode extends Node2D
signal node_clicked(linked_battle_map: PackedScene)


@export var linked_battle_map: PackedScene


func _on_click_detection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("clicked!")
