class_name WorldMapController extends Control
signal map_node_clicked(battle_map: PackedScene, map_node: MapNode)

@onready var map_node_controller:MapNodeController = $MapNodeController

func _on_map_node_controller_node_clicked(battle_map, map_node):
	
	map_node_clicked.emit(battle_map, map_node)
