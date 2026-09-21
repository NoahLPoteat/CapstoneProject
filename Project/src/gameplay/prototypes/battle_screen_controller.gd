class_name BattleScreen extends Control
signal turn_changed(new_active_unit: UnitBase)

@onready var battle_map_controller: BattleMapControl = $SubViewportContainer/SubViewport/BattleMapController
@onready var overlay_node: Control = $BattleGUI

enum TURN_STATES {
	MOVING,
	ATTACKING,
	END_IDLE
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
	pass

var current_state: TURN_STATES

func state_process():
	match current_state:
		TURN_STATES.MOVING:
			##Highlight tiles based on units available spaces left
			pass
		TURN_STATES.ATTACKING:
			##Get ability unit is attempting to use / active and highlight
			##	valid target tiles
			pass
		TURN_STATES.END_IDLE:
			##if unit enemy, maybe way a second then end turn :)
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

func state_left(old_state: TURN_STATES):
	if current_state == null:
		print("Unit state broken, check state_left() in battle_screen_controller.gd")
		return 
	
	return

##This is where the main game state logic will be held.
##	We will keep track of current unit turn, what their state is
## (moving, using ability, selecting ability, etc)
## along with expending their resources.
##
## we will also generate and place the unit portrait, abilities, and stats
## 	when the turn changes.
## 
## Abstract
## This will serve as the main interchange between
## the node based game structure and the GUI based game controls
## 
## TODO:
## [X] retrieve units from battlemap
## [X] load units into a turn order (revise for proper turn order later)
## [] setup function for sending unit stats, abilities, and portrait to the overlay.
## [] setup unit states for (moving, attacking, selecting ability, etc)
## [X] retrieve input from mouse, if over viewport detect which tile
## [X] move whatever currentUnit is to clicked tile
## [] if unit has movementPoints available let them move to a clicked tile
## [] Add button to end turn (and functionality for said button)
## [] Calculate tiles within range based on movement points, and then highlight those tiles
##		by changing them to the ID for the highlighted tile, if hovered by mouse make it the
##		tile that has the dot in the center


##Mouse Input Handling
##	NOTE (This should be moved down a node to battleScreen Controller where it can handle
##		  the mouse input for abilities, and other things)
##	[X]We need to first detect if the mouse in hovering over the subviewport
##	[]If it is we need switch over what the current unit state is
##	[]If movable, attempt to move, if abi_selected, attempt to use ability
##	[]else the buttons and such should handle the input themselves
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug_turn_skip"):
		next_turn()
	
	
	if event is InputEventMouse:
		var pos = event.global_position
		if sub_view_rect.has_point(pos) and self.visible:
			if event is InputEventMouseButton:
				battle_map_controller.attempt_move_unit(pos, current_unit)
				
			elif event is InputEventMouseMotion:
				battle_map_controller.hovering_tile(pos)


##Updates the overlay GUI with the new unit data
func update_gui():
	overlay_node.update_gui(current_unit)

func next_turn():
	#print("turn changed")
	
	if turn_index >= len(turn_order):
		turn_index = 0 #reset back to start of turn order
	
	current_unit = turn_order[turn_index]
	update_gui()
	
	turn_index += 1


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
	
	next_turn()
	
	print(turn_order, current_unit.unit_name)

func retrieve_units():
	return battle_map_controller.get_units_arr()
