extends Node2D
signal node_clicked(battle_map: PackedScene)

@export var starting_map: MapNode
var map_nodes: Array[MapNode] = []

func _ready():
	link_map_nodes()
	#unlock_maps(starting_map)

#Loops through each child map node, and links them to the signal.
#When(if) we set up acts, we will change to a more data driven approach
# where we link as we load them in from the data
func link_map_nodes():
	for map_node: MapNode in get_children():
		#print(map_node)
		map_node.node_clicked.connect(map_node_clicked.bind(map_node))
		map_nodes.append(map_node)
		
		if map_node!=starting_map:
			map_node.visible = false

func map_node_clicked(map_node: MapNode):
	#print("debug!")
	node_clicked.emit(map_node.linked_battle_map)

##unlocks the post_maps of a map
func unlock_maps(map_node: MapNode):
	for n:MapNode in map_nodes:
		if n == map_node:
			for map in n.post_maps:
				##HERE IS WHERE TO PUT CODE FOR MAKING LINES GO TO NEW MAPS
				
				map.visible = true
