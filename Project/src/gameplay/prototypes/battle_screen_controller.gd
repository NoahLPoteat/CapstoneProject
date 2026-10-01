class_name BattleScreen extends Control
signal turn_changed(new_active_unit: UnitBase)

@onready var battle_map_controller: BattleMapControl = $SubViewportContainer/SubViewport/BattleMapController
@onready var overlay_node: Control = $BattleGUI

enum BATTLE_PHASES{
	NONE,
	PLACEMENT,
	ALLY_TURN,
	ENEMY_TURN,
	END_SCREEN
}

var current_battle_phase: BATTLE_PHASES

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

##unfortunate requirement due to issues with the viewport
var offset_x: int = 81
var offset_y: int = 11

func _ready():
	init_turn_order()

func _process(delta: float) -> void:
	turn_state_process()

var current_state: TURN_STATES

var old_tiles: Array = []
func turn_state_process():
	match current_state:
		TURN_STATES.MOVING:
			
			for tile in old_tiles:
				battle_map_controller.highlight_tile(battle_map_controller.atlas_enum.DEF, tile, true)
			old_tiles = []
			var moves_left = current_unit.movement_left
			##Highlight tiles based on units available spaces left
			for x in range(moves_left * -1, moves_left + 1):
				for y in range(moves_left * -1, moves_left + 1):
					if abs(x) + abs(y) <= moves_left:
						var to_pos = current_unit.map_position + Vector2i(x, y)
						battle_map_controller.highlight_tile(
							battle_map_controller.atlas_enum.WALKABLE, to_pos)
						old_tiles.append(to_pos)
			
			
		TURN_STATES.STRIKING:
			##Cover tiles valid in current units strike distance
			##	Use similar structure to the moving tiles (but different atl)
			##Mouse Detection in lower node will be handling finer details
			for tile in old_tiles:
				battle_map_controller.highlight_tile(battle_map_controller.atlas_enum.DEF, tile, true)
			old_tiles = []
			
			var strike: AbilityBase = current_unit.get_strike()
			
			
			if strike == null:
				return
			
			var can_use_abi: bool = current_unit.can_use_ability()
			
			if not can_use_abi:
				return
			
			var dist = strike.abi_range
			for x in range(dist * -1, dist + 1):
				for y in range(dist * -1, dist + 1):
					if abs(x) + abs(y) <= dist:
						var to_pos = current_unit.map_position + Vector2i(x, y)
						
						if to_pos == current_unit.map_position:
							continue
						
						battle_map_controller.highlight_tile(
							battle_map_controller.atlas_enum.ATTACKABLE, to_pos, true)
						old_tiles.append(to_pos)
					
			
			pass
		TURN_STATES.ABILITY:
			## Get units current chosen ability, mark all tiles in range
			for tile in old_tiles:
				battle_map_controller.highlight_tile(battle_map_controller.atlas_enum.DEF, tile, true)
			old_tiles = []
			
			pass
		_:
			pass



func change_unit_state(new_state: TURN_STATES):
	state_left(current_state)
	current_state = new_state
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
	if current_state == null:
		print("Unit state broken, check state_left() in battle_screen_controller.gd")
		return 
	
	return

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug_turn_skip"):
		next_turn()
	
	if event is InputEventMouse:
		var pos = event.global_position
		if sub_view_rect.has_point(pos) and self.visible:
			match current_state:
				TURN_STATES.MOVING:
					if event is InputEventMouseButton:
						if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
							battle_map_controller.attempt_move_unit(pos, current_unit)
				TURN_STATES.STRIKING:
					if event is InputEventMouseButton:
						if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
							battle_map_controller.attempt_strike_unit(pos, current_unit)
				TURN_STATES.ABILITY:
					pass
				_:
					pass
			
			if event is InputEventMouseMotion:
				battle_map_controller.hovering_tile(pos)


##Updates the overlay GUI with the new unit data
func update_gui():
	overlay_node.update_gui(current_unit, current_battle_phase, current_state)

func next_turn():
	#print("turn changed")
	
	if turn_index >= len(turn_order):
		turn_index = 0 #reset back to start of turn order
	
	current_unit = turn_order[turn_index]
	current_unit.reset_turn()
	current_state = TURN_STATES.MOVING
	update_gui()
	turn_index += 1


##Initilizes the turn order, and places units into their starting position
func init_turn_order():
	turn_order = []
	
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
	
	for unit: UnitBase in turn_order:
		print("Attempting unit starting move debug")
		battle_map_controller.attempt_move_unit(Vector2.ZERO, unit, unit.starting_pos, true, true)
	
	next_turn()
	
	print(turn_order, current_unit.unit_name)

func retrieve_units():
	return battle_map_controller.get_units_arr()


func _on_active_unit_button_ctr_button_pressed(choice: UnitButton.BUTTON_CHOICE) -> void:
	match choice:
		UnitButton.BUTTON_CHOICE.MOVEMENT:
			if current_state == TURN_STATES.MOVING:
				return
			else:
				change_unit_state(TURN_STATES.MOVING)
				update_gui()
		UnitButton.BUTTON_CHOICE.STRIKE:
			if current_state == TURN_STATES.STRIKING:
				return
			else:
				change_unit_state(TURN_STATES.STRIKING)
				update_gui()
		UnitButton.BUTTON_CHOICE.ABILITY:
			if current_state == TURN_STATES.ABILITY:
				return
			else:
				change_unit_state(TURN_STATES.ABILITY)
				update_gui()
		_:
			pass


func _on_end_turn_end_turn_button_pressed() -> void:
	next_turn()
