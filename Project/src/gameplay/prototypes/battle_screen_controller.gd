class_name BattleScreen extends Control
signal turn_changed(new_active_unit: UnitBase)
signal game_over(game_won: bool, battle_map: BattleMapNode)

@onready var battle_map_controller: BattleMapControl = $SubViewportContainer/SubViewport/BattleMapController
@onready var overlay_node: BattleGUI = $BattleGUI

enum BATTLE_PHASES{
	NONE,
	PLACEMENT,
	ALLY_TURN,
	ENEMY_TURN,
	END_SCREEN
}

enum TURN_STATES {
	MOVING,
	STRIKING,
	ABILITY
}

##Used solely for checking if mouse input is in the subviewport
##	so we can send the input down if needed
var sub_view_rect: Rect2 = Rect2i(81, 11, 228, 158)

var turn_order: Array[UnitBase] = []
var turn_index: int = 0
var current_unit: UnitBase
var old_tiles: Array = []

##unfortunate requirement due to issues with the viewport
var offset_x: int = 81
var offset_y: int = 11
var battle_active: bool = false

func _ready():
	pass

func _process(delta: float) -> void:
	if battle_active:
		battle_state_process()
	#print(turn_order, turn_index)


var enemy_ai_running: bool = false
var current_battle_state: BATTLE_PHASES
func battle_state_process():
	
	match current_battle_state:
		BATTLE_PHASES.PLACEMENT:
			placement_process()
			update_gui()
			##highlight all placeable tiles (hardcoded :3)
			##highlight all non-placeable with the nothing tile
			##	^NOTE This would work but the deco tiles would still be there
			##		  so consider just not caring :3
			
			return
		BATTLE_PHASES.ALLY_TURN:
			turn_state_process()
			return
		BATTLE_PHASES.ENEMY_TURN:
			if not enemy_ai_running:
				enemy_ai()
			#turn_state_process()
			return
		BATTLE_PHASES.END_SCREEN:
			pass
		BATTLE_PHASES.NONE: 
			##this state should only be reached while there is
			#	no active battle
			#meaning, if this state exists we should go to the placement phase
			#	cross ref the way battles are initiated to make sure everything works
			pass

##helper to not clog up process func
func placement_process():
	## reset tiles
	for tile in old_tiles:
		battle_map_controller.highlight_tile(battle_map_controller.atlas_enum.DEF, tile, true, true)
	old_tiles = []
	
	var placeable_tiles = battle_map_controller.battle_map.placeable_tiles
	
	for tile in placeable_tiles:
		battle_map_controller.highlight_tile(battle_map_controller.atlas_enum.WALKABLE, tile)
		old_tiles.append(tile)

##temp for testing
var custom_timer: Timer
var t: float
func enemy_ai():
	var this_enemy = current_unit
	enemy_ai_running = true
	custom_timer = Timer.new()
	add_child(custom_timer)
	custom_timer.wait_time = 1.0
	custom_timer.one_shot = true
	
	
	
	for tile in old_tiles:
		battle_map_controller.highlight_tile(battle_map_controller.atlas_enum.DEF, tile, true, true)
	old_tiles = []
	
	#loop through turn_order, check each unit
	#	find closest
	var moves_left = current_unit.movement_left
	
	
	#highlight valid movement tiles
	for x in range(moves_left * -1, moves_left + 1):
		for y in range(moves_left * -1, moves_left + 1):
			if abs(x) + abs(y) <= moves_left:
				var to_pos = current_unit.map_position + Vector2i(x, y)
				battle_map_controller.highlight_tile(
					battle_map_controller.atlas_enum.WALKABLE, to_pos)
				old_tiles.append(to_pos)
	
	t = randf_range(0.8, 1.2)
	custom_timer.start(t)
	await custom_timer.timeout
	
	var s_iso: Vector2i = this_enemy.map_position
	var closest_unit: UnitBase
	var closest_dist: float = 10000000.0
	for unit in turn_order:
		if this_enemy == unit:
			continue
		var t_iso: Vector2i = unit.map_position
		var d = s_iso.distance_to(t_iso)
		if d <= closest_dist and this_enemy.is_ally != unit.is_ally and not unit.unit_dead:
			closest_dist = d
			closest_unit = unit
	
	if not closest_unit:
		return
	
	var closest_tile: Vector2i = Vector2i(-1000, -1000)
	closest_dist = 10000000.0
	for tile: Vector2i in old_tiles: #each tile in old_tiles is actually a moveable tile rn
		var d = tile.distance_to(closest_unit.map_position)
		if d <= closest_dist and not battle_map_controller.tile_has_unit(tile) and battle_map_controller.has_tile(tile):
			closest_dist = d
			closest_tile = tile
		battle_map_controller.highlight_tile(battle_map_controller.atlas_enum.DEF, tile, true, true)
	old_tiles = []
	print(closest_tile, closest_unit, closest_dist)
	battle_map_controller.attempt_move_unit(Vector2(0,0), this_enemy, closest_tile, true)
	
	#get strike and display tiles (abilities come later)
	var strike: AbilityBase = this_enemy.get_strike()
	
	for tile in strike.get_tiles():
		var t_off: Vector2i = tile + this_enemy.map_position
		if t_off == current_unit.map_position:
			continue
		
		battle_map_controller.highlight_tile(
			battle_map_controller.atlas_enum.ATTACKABLE, t_off, true
		)
		old_tiles.append(t_off)
	
	t = randf_range(0.8, 1.2)
	custom_timer.start(t)
	await custom_timer.timeout
	
	var first_enemy_in_range: UnitBase = null
	var striking_tile: Vector2i = Vector2i(-1000,-1000)
	for tile in old_tiles:
		if battle_map_controller.tile_has_unit(tile):
			var tar: UnitBase = battle_map_controller.unit_from_pos[tile]
			if tar.is_ally != this_enemy.is_ally and not tar.unit_dead:
				first_enemy_in_range = tar
				striking_tile = first_enemy_in_range.map_position
				break
	 
	for tile in old_tiles: #reset tiles
		battle_map_controller.highlight_tile(battle_map_controller.atlas_enum.DEF, tile, true, true)
	old_tiles = []
	
	#attempt to strike a unit if one in range
	if first_enemy_in_range != null and striking_tile != Vector2i(-1000,-1000):
		battle_map_controller.attempt_strike_unit(Vector2(-1,-1), this_enemy, striking_tile, true)
	
	t = randf_range(0.8, 1.2)
	custom_timer.start(t)
	await custom_timer.timeout
	
	enemy_ai_running = false
	next_turn(true)

func change_battle_state(new_state: BATTLE_PHASES):
	exit_battle_state(current_battle_state)
	current_battle_state = new_state
	match new_state:
		BATTLE_PHASES.PLACEMENT:
			var arr = retrieve_units()
			overlay_node.set_placeables(arr[0])
		BATTLE_PHASES.ALLY_TURN:
			pass
		BATTLE_PHASES.ENEMY_TURN:
			pass
		BATTLE_PHASES.END_SCREEN:
			pass
		BATTLE_PHASES.NONE:
			pass

func exit_battle_state(old_state: BATTLE_PHASES):
	match old_state:
		BATTLE_PHASES.PLACEMENT:
			pass
		BATTLE_PHASES.ALLY_TURN:
			pass
		BATTLE_PHASES.ENEMY_TURN:
			enemy_ai_running = false
		BATTLE_PHASES.END_SCREEN:
			pass
		BATTLE_PHASES.NONE:
			pass

var hovered_iso: Vector2i = Vector2i(-1000, -1000)
var current_turn_state: TURN_STATES
func turn_state_process():
	for tile in old_tiles:
		battle_map_controller.highlight_tile(battle_map_controller.atlas_enum.DEF, tile, true, true)
	old_tiles = []
	
	match current_turn_state:
		TURN_STATES.MOVING:
			var moves_left = current_unit.movement_left
			##Highlight tiles based on units available spaces left
			for x in range(moves_left * -1, moves_left + 1):
				for y in range(moves_left * -1, moves_left + 1):
					if abs(x) + abs(y) <= moves_left:
						var to_pos = current_unit.map_position + Vector2i(x, y)
						battle_map_controller.highlight_tile(
							battle_map_controller.atlas_enum.WALKABLE, to_pos)
						old_tiles.append(to_pos)
			
			pass
		TURN_STATES.STRIKING:
			var strike: AbilityBase = current_unit.get_strike()
			if strike == null:
				return
			
			var can_use_abi: bool = current_unit.can_use_ability()
			if not can_use_abi:
				return
			
			var tiles = strike.get_tiles()
			for t in tiles:
				var t_off = current_unit.map_position + t
				if t_off == current_unit.map_position:
					continue
				
				battle_map_controller.highlight_tile(
					battle_map_controller.atlas_enum.ATTACKABLE, t_off, true
				)
				old_tiles.append(t_off)
			
			pass
		TURN_STATES.ABILITY:
			var abi: AdvancedAbility = current_unit.chosen_ability
			if abi == null:
				return
			var can_use_abi: bool = current_unit.can_use_ability()
			if not can_use_abi:
				return
			
			#print("IM HERE", current_unit.chosen_ability)
			
			var tiles = abi.get_tiles()
			for t in tiles:
				var t_off = current_unit.map_position + t
				if t_off == current_unit.map_position:
					continue
				
				battle_map_controller.highlight_tile(
					battle_map_controller.atlas_enum.ATTACKABLE, t_off, true
				)
				old_tiles.append(t_off)
			
			tiles = abi.get_shape()
			for t in tiles:
				var t_off = hovered_iso + t
				battle_map_controller.highlight_tile(
					BattleMapControl.atlas_enum.WALKABLE, t_off, true
				)
				old_tiles.append(t_off)
			
			pass
		_:
			pass


func change_unit_state(new_state: TURN_STATES):
	state_left(current_turn_state)
	current_turn_state = new_state
	match new_state:
		TURN_STATES.MOVING:
			
			var nav: AStar2D = battle_map_controller.get_nav_sys()
			##calculate all tiles within distance that the unit can move to
			##	keep track of all of those coordinates and their old atl coords
			##Change them each to the atl coord of the moveable tile
			
			
			pass
		_:
			pass

func state_left(old_state: TURN_STATES):
	if current_turn_state == null:
		print("Unit state broken, check state_left() in battle_screen_controller.gd")
		return 
	
	return

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug_turn_skip"):
		next_turn()
	
	if event is InputEventMouse:
		var pos = event.global_position
		if sub_view_rect.has_point(pos) and self.visible:
			if current_battle_state == BATTLE_PHASES.ALLY_TURN:
				match current_turn_state:
					TURN_STATES.MOVING:
						if event is InputEventMouseButton:
							if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
								battle_map_controller.attempt_move_unit(pos, current_unit)
					TURN_STATES.STRIKING:
						if event is InputEventMouseButton:
							if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
								if current_unit.can_use_ability():
									battle_map_controller.attempt_strike_unit(pos, current_unit)
									update_gui()
					TURN_STATES.ABILITY:
						if event is InputEventMouseButton:
							if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
								if  current_unit.can_use_ability():
									battle_map_controller.attempt_use_ability(pos, current_unit)
								update_gui()
						pass
					_:
						pass
				if event is InputEventMouseMotion:
					hovered_iso = battle_map_controller.iso_from_global(pos)
					battle_map_controller.hovering_tile(pos)
					
			if current_battle_state == BATTLE_PHASES.PLACEMENT:
				if event is InputEventMouseButton:
					#attempt place_unit
					var unit: UnitBase = overlay_node.placeables[0]
					var to_pos_iso: Vector2i = battle_map_controller.iso_from_global(pos)
					
					if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
						if battle_map_controller.attempt_place_unit(unit, to_pos_iso):
							overlay_node.placeables.remove_at(0)
				
				if event is InputEventMouseMotion:
					battle_map_controller.hovering_tile(pos)

##Updates the overlay GUI with the new unit data
func update_gui():
	if current_battle_state == BATTLE_PHASES.NONE:
		return
	if current_battle_state == BATTLE_PHASES.PLACEMENT:
		overlay_node.update_placement()
	else:
		overlay_node.update_gui(current_unit, current_battle_state, current_turn_state)

func next_turn(override: bool = false):
	if not override and not current_unit.is_ally and not current_unit.unit_dead:
		return
	
	if turn_index >= turn_order.size():
		turn_index = 0 #reset back to start of turn order
	
	current_unit = turn_order[turn_index]
	if current_unit.unit_dead:
		#check_win_loss()
		turn_index += 1
		next_turn()
		return
	
	current_unit.reset_turn()
	
	
	if current_unit.is_ally:
		#print("ally")
		change_battle_state(BATTLE_PHASES.ALLY_TURN)
	else:
		#print("enemy")
		change_battle_state(BATTLE_PHASES.ENEMY_TURN)
	
	current_turn_state = TURN_STATES.MOVING
	update_gui()
	turn_index += 1

##Initilizes the turn order, and places units into their starting position
func init_turn_order():
	turn_order = []
	turn_index = 0
	
	var unit_arrs = retrieve_units()
	var ally_arr = unit_arrs[0]
	var enemy_arr = unit_arrs[1]
	var ally_len = len(ally_arr)
	var enemy_len = len(enemy_arr)
	
	var big_enemy: bool = enemy_len >= ally_len
	
	if big_enemy:
		for i in range(enemy_len):
			if i < ally_len:
				turn_order.append(ally_arr[i])
			turn_order.append(enemy_arr[i])
	else:
		for i in range(ally_len):
			if i < enemy_len:
				turn_order.append(enemy_arr[i])
			turn_order.append(ally_arr[i])
	
	var i = 0
	for unit: UnitBase in turn_order:
		unit.pre_fight_init()
		print("Attempting unit starting move debug, and turn order setup")
		unit.turn_order_pos = i
		
		if not unit.is_ally:
			battle_map_controller.attempt_move_unit(Vector2.ZERO, unit, unit.starting_pos, true, true)
		#connect each units on_death signal to a function for killing them
		unit.unit_died.connect(unit_death.bind(unit))
		i += 1
	
	#next_turn()
	
	print("Units Loaded (bsc.gd)", turn_order)

func retrieve_units():
	return battle_map_controller.get_units_arr()

func unit_death(unit: UnitBase):
	check_win_loss()

func check_win_loss():
	var gt1_ally_alive: bool = false
	var gt1_enemy_alive: bool = false
	for unit in turn_order:
		if unit.is_ally:
			if not unit.unit_dead:
				gt1_ally_alive = true
		else:
			if not unit.unit_dead:
				gt1_enemy_alive = true
	
	if gt1_ally_alive and gt1_enemy_alive:
		return
	
	var current_map: BattleMapNode = battle_map_controller.battle_map
	
	if not gt1_ally_alive and gt1_enemy_alive:
		print("LOSELOSELOSE")
		game_over.emit(false, current_map)
	
	if gt1_ally_alive and not gt1_enemy_alive:
		game_over.emit(true, current_map)
		print("WONWONWON")
	
	if not gt1_ally_alive and not gt1_enemy_alive:
		print("very broken, plz fix (check_win_loss() bsc.gd)")
		return

func _on_active_unit_button_ctr_button_pressed(choice: UnitButton.BUTTON_CHOICE) -> void:
	match choice:
		UnitButton.BUTTON_CHOICE.MOVEMENT:
			if current_turn_state == TURN_STATES.MOVING:
				return
			else:
				change_unit_state(TURN_STATES.MOVING)
				update_gui()
		UnitButton.BUTTON_CHOICE.STRIKE:
			if current_turn_state == TURN_STATES.STRIKING:
				return
			else:
				change_unit_state(TURN_STATES.STRIKING)
				update_gui()
		UnitButton.BUTTON_CHOICE.ABILITY:
			if current_turn_state == TURN_STATES.ABILITY:
				return
			else:
				change_unit_state(TURN_STATES.ABILITY)
				update_gui()
		_:
			pass

func _on_end_turn_end_turn_button_pressed() -> void:
	next_turn()

func unload_map():
	change_battle_state(BATTLE_PHASES.NONE)
	battle_map_controller.unload_map()
	battle_active = false
	old_tiles = []

func _on_battle_map_controller_map_ready():
	change_battle_state(BATTLE_PHASES.PLACEMENT)
	battle_active = true

func _on_placement_done():
	print("Placement phase over, bsc.gd")
	
	init_turn_order()
	next_turn(true)
