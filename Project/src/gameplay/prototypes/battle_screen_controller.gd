extends Control

@onready var battle_map_controller: BattleMapControl = $SubViewportContainer/SubViewport/BattleMapController
var unit_list

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
## [] retrieve units from battlemap
## [] load units into a turn order (revise for proper turn order later)
## [] setup function for sending unit stats, abilities, and portrait to the overlay.
## [] setup unit states for (moving, attacking, selecting ability, etc)
## [] retrieve input from mouse, if over viewport detect which tile
## [] if unit has movementPoints available let them move to a clicked tile
## [] Add button to end turn (and functionality for said button)
## [] Calculate tiles within range based on movement points, and then highlight those tiles
##		by changing them to the ID for the highlighted tile, if hovered by mouse make it the
##		tile that has the dot in the center



##Updates the overlay GUI with the new unit data
func update_gui():
	pass

func next_turn():
	pass


func init_turn_order():
	pass

func retrieve_units():
	pass
