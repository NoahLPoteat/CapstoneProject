class_name BattleMapControl extends Node2D
signal turn_changed()
signal update_gui()

var nav_sys = AStar2D.new()

##NOTE later this will be loaded on the fly, for now its here
@onready var battle_map: BattleMapNode = $MapContainer/Map

var unit_pos_from_pos: Dictionary = {}
var unit_pos_from_unit: Dictionary = {}

var turn_order
var current_unit: UnitBase

func _ready():
	#temporary until while we test
	load_map(battle_map)
	print(nav_sys.get_point_count())

func move_current_unit(to_pos: Vector2i):
	if not current_unit:
		print("Attempting to move unit without one selected")
		return
	
	unit_pos_from_pos[to_pos] = current_unit
	unit_pos_from_unit[current_unit] = to_pos

func load_battle():
	pass

func start_battle():
	pass

func get_current_unit():
	if current_unit:
		return current_unit
	else:
		return null


##generates the navigation system, and extracts the units from the map
func load_map(map: BattleMapNode):
	#battle_map = map
	
	##this is where we will setup map height in the future
	var used_cells = map.main_tile.get_used_cells()
	
	var tile_map: TileMapLayer = map.main_tile
	
	for cell in used_cells:
		
		var id = gen_cell_id(cell)
		var world_pos = tile_map.map_to_local(cell)
		nav_sys.add_point(id, world_pos)
	
	for cell in used_cells:
		var id = gen_cell_id(cell)
		var neighbors = [
			cell + Vector2i.UP,
			cell + Vector2i.DOWN,
			cell + Vector2i.LEFT,
			cell + Vector2i.RIGHT
		]
		
		for neighbor in neighbors:
			if tile_map.get_cell_source_id(neighbor) != -1: # check if neighbor exists
				var neighbor_id = gen_cell_id(neighbor)
				if nav_sys.has_point(neighbor_id) and not nav_sys.are_points_connected(id, neighbor_id):
					nav_sys.connect_points(id, neighbor_id, true)

func gen_cell_id(cell: Vector2i):
	return cell.x + cell.y * 114901
