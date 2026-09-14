extends Node2D
signal node_clicked(battle_map: PackedScene)


func _ready():
	link_map_nodes()

#Loops through each child map node, and links them to the signal.
#When(if) we set up acts, we will change to a more data driven approach
# where we link as we load them in from the data
func link_map_nodes():
	for map_node: MapNode in get_children():
		#print(map_node)
		map_node.node_clicked.connect(map_node_clicked.bind(map_node))



func map_node_clicked(map_node: MapNode):
	#print("debug!")
	node_clicked.emit(map_node.linked_battle_map)
