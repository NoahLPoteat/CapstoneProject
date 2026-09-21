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
var offset_x: float = 81.0
var offset_y: float = 15.0
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
	
	if battle_map.main_tile.get_cell_source_id(to_pos_iso) == 0:
	
		unit_pos_from_pos[to_pos_iso] = unit
		unit_pos_from_unit[unit] = to_pos_iso
		
		var to_pos_local = battle_map.main_tile.map_to_local(to_pos_iso)
		
		#print(to_pos_local, to_pos_global, to_pos_iso)
		
		unit.position = to_pos_local -  - Vector2(0, -8)


enum atlas_enum {
	DEF,
	WALKABLE,
	HOVERED
}
var map_atlas: Dictionary = {
	atlas_enum.DEF : Vector2i(0, 0),
	atlas_enum.WALKABLE : Vector2i(2, 0),
	atlas_enum.HOVERED : Vector2i(3, 0)
}

var current_hovered: Vector2i = Vector2i(-10000,-10000)
var current_tile_old_atl: Vector2i = Vector2i(-1,-1)
func hovering_tile(pos_global: Vector2):
	var pos_iso = iso_from_global(pos_global)
	
	
	var map = battle_map.main_tile
	var new_cell_id = battle_map.main_tile.get_cell_source_id(pos_iso)
	
	print(pos_iso, current_hovered)
	
	## == 1 means the tile is in our set
	## Our maps currently only use 1 tile, 
	## so this may have to change in the future
	if new_cell_id == 0:
		##replace current hovered with the default tile
		## keep track of tiles old atlas texture
		
		##If we are still on the same tile
		if current_hovered == pos_iso:
			map.set_cell(current_hovered, 0, map_atlas[atlas_enum.HOVERED])
		else: ##We are hovered on a new tile
			## Swap current_tile pos back to DEF
			## change current tile to new tile
			## swap new tile to hovered
			
			if current_tile_old_atl:
				map.set_cell(current_hovered, 0, current_tile_old_atl)
			else:
				map.set_cell(current_hovered, 0, map_atlas[atlas_enum.DEF])
			
			
			current_hovered = pos_iso
			current_tile_old_atl = map.get_cell_atlas_coords(current_hovered)
			
			map.set_cell(current_hovered, 0, map_atlas[atlas_enum.HOVERED])
	else:
		if current_tile_old_atl:
			map.set_cell(current_hovered, 0, current_tile_old_atl)
		else:
			map.set_cell(current_hovered, 0, map_atlas[atlas_enum.DEF])


func highlight_tile(to_change: atlas_enum, iso_pos: Vector2i):
	#change the target iso tile to whatever atlas_enum it needs
	pass


func get_nav_sys():
	return nav_sys


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
	local_pos -= offset_vec
	return battle_map.main_tile.local_to_map(local_pos)
