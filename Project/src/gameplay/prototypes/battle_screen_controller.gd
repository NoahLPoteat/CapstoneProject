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
	
	#get rid of when we have a proper placement phase 
	next_turn()

func _process(delta: float) -> void:
	battle_state_process()


#placement - just start turn order fo now
#	in the future
#	display a side panel of all ally units
#	go through order allowing user to place
#	each unit in a select area
#	first we need tiles to have data on which tiles should be placeable
#ALLY_TURN
#	pass down to current_turn_process which handles all ally turn behaivour
#ENEMY_TURN
#	for now have a quick function to just make enemy unit move to nearest ally unit
#	and attack if in range
#	in the future we will offset this to the enemy specificly
#	allowing them to control their own ai
#END_SCREEN
#	if game won display a win screen and pass up that the user has won
#	if game lost then display a loss screen and pass up without has won
#NONE
#	default state, potentially use to just swap to placement phase
var current_battle_state: BATTLE_PHASES
func battle_state_process():
	
	match current_battle_state:
		BATTLE_PHASES.PLACEMENT:
			##Most of placement phase will be handled by the input function
			##	and the gui updating
			##for now we just go to ally_turn
			change_battle_state(BATTLE_PHASES.ALLY_TURN)
		BATTLE_PHASES.ALLY_TURN:
			turn_state_process()
		BATTLE_PHASES.ENEMY_TURN:
			turn_state_process()
		BATTLE_PHASES.END_SCREEN:
			pass
		BATTLE_PHASES.NONE: 
			##this state should only be reached while there is
			#	no active battle
			#meaning, if this state exists we should go to the placement phase
			#	cross ref the way battles are initiated to make sure everything works
			change_battle_state(BATTLE_PHASES.PLACEMENT)
			pass

func change_battle_state(new_state: BATTLE_PHASES):
	exit_battle_state(current_battle_state)
	current_battle_state = new_state
	match new_state:
		BATTLE_PHASES.PLACEMENT:
			pass
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
			pass
		BATTLE_PHASES.END_SCREEN:
			pass
		BATTLE_PHASES.NONE:
			pass

var current_turn_state: TURN_STATES
var old_tiles: Array = []
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
			## Get units current chosen ability, mark all tiles in range
			for tile in old_tiles:
				battle_map_controller.highlight_tile(battle_map_controller.atlas_enum.DEF, tile, true)
			old_tiles = []
			
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
					pass
				_:
					pass
			
			if event is InputEventMouseMotion:
				battle_map_controller.hovering_tile(pos)


##Updates the overlay GUI with the new unit data
func update_gui():
	overlay_node.update_gui(current_unit, current_battle_state, current_turn_state)

func next_turn():
	if turn_index >= len(turn_order):
		turn_index = 0 #reset back to start of turn order
	
	current_unit = turn_order[turn_index]
	current_unit.reset_turn()
	
	if current_unit.is_ally:
		change_battle_state(BATTLE_PHASES.ALLY_TURN)
	else:
		change_battle_state(BATTLE_PHASES.ENEMY_TURN)
	
	current_turn_state = TURN_STATES.MOVING
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
	
	var i = 0
	for unit: UnitBase in turn_order:
		print("Attempting unit starting move debug, and turn order setup")
		unit.turn_order_pos = i
		battle_map_controller.attempt_move_unit(Vector2.ZERO, unit, unit.starting_pos, true, true)
		#connect each units on_death signal to a function for killing them
		unit.unit_died.connect(unit_death.bind(unit))
		i += 1
	
	#next_turn()
	
	print("Units Loaded (bsc.gd)", turn_order)

func retrieve_units():
	return battle_map_controller.get_units_arr()

func unit_death(unit: UnitBase):
	turn_order.remove_at(unit.turn_order_pos)
	unit.queue_free()
	
	battle_map_controller.remove_unit(unit)
	
	#update loop
	var i = 0
	for u in turn_order:
		u.turn_order_pos = i
		i += 1
	
	check_win_loss()

## two options
#	either return 2 bools, 1 for whether the game is over
#	another for if won
#OR
# just keep the logic in function and return when called elsewhere
func check_win_loss():
	pass

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
