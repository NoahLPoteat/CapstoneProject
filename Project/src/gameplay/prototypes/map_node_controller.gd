extends Node2D
signal node_clicked(battle_map: PackedScene)



#Loops through each child map node, and links them to the signal.
#When(if) we set up acts, we will change to a more data driven approach
# where we link as we load them in from the data
func link_map_nodes():
	for map_node: MapNode in get_children():
		pass



func map_node_clicked(map_node: MapNode):
	node_clicked.emit(map_node.linked_battle_map)
