class_name BattleMapControl extends Node2D
signal turn_changed()
signal update_gui()

var nav_sys = AStar2D.new()

@onready var map_container: MapContainer = $MapContainer
@onready var ally_unit_container: Node2D = $AllyUnitContainer

##NOTE later this will be loaded on the fly, for now its here
@onready var battle_map: BattleMapNode = $MapContainer/Map

var unit_pos_from_pos = {} 
var unit_pos_from_unit = {}

##unfortunate requirement due to issues with the viewport
var offset_x: int = 81
var offset_y: int = 15
var offset_vec: Vector2 = Vector2(offset_x, offset_y)


func _ready():
	#temporary until while we test
	load_map(battle_map)
	print(nav_sys.get_point_count())
	_on_map_container_need_nav()

func load_battle():
	pass

func start_battle():
	pass

func attempt_move_unit(to_pos_global: Vector2, unit: UnitBase):
	if not unit:
		print("Attempting to move unit without one selected")
		return
	
	var to_pos_iso = iso_from_global(to_pos_global)
	
	unit_pos_from_pos[to_pos_iso] = unit
	unit_pos_from_unit[unit] = to_pos_iso
	
	var to_pos_local = battle_map.main_tile.map_to_local(to_pos_iso)
	
	#print(to_pos_local, to_pos_global, to_pos_iso)
	
	unit.position = to_pos_local - Vector2(offset_x, offset_y)

var current_hovered: Vector2i = Vector2i(-10000,-10000)
func hovering_tile(pos_global: Vector2):
	var pos_iso = iso_from_global(pos_global - offset_vec)
	
	var new_cell_id = battle_map.main_tile.get_cell_source_id(pos_iso)
	
	

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
	var id = abs(cell.x + cell.y * 114901)
	return id


func _on_map_container_need_nav() -> void:
	map_container.update_nav_mesh(nav_sys)

##returns an array with index 0 being ally units, and index 1 being enemy units
func get_units_arr():
	var enemy_arr = battle_map.get_enemy_units()
	var ally_arr = ally_unit_container.get_children()
	return [ally_arr, enemy_arr]



func iso_from_global(pos: Vector2):
	var local_pos = battle_map.main_tile.to_local(pos)
	return battle_map.main_tile.local_to_map(local_pos)
