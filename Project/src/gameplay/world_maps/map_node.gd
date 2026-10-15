class_name MapNode extends Node2D
signal node_clicked()


@export var linked_battle_map: PackedScene
@export var post_maps: Array[MapNode]

func _on_click_detection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			node_clicked.emit()
			#print("clicked! - In the map_node.gd")
