class_name WorldMapController extends Control
signal map_node_clicked(battle_map: PackedScene)


func _on_map_node_controller_node_clicked(battle_map):
	
	map_node_clicked.emit(battle_map)
