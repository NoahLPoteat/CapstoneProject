extends Control

@onready var trans_node: ScreenTransitionHandler = $TransitionNode
@onready var battle_screen_control = $BattleScreenController
@onready var world_map_control: WorldMapController = $WorldMapController

##Used solely for checking if mouse input is in the subviewport
##	so we can send the input down if needed
var sub_view_rect: Rect2 = Rect2i(81, 11, 228, 158)

## Here we handle loading the battlemap, and transitioning from the world map
## 	to the world map
##NOTE the battlemap node will handle placing units and actually utilizing the map
##	here we just, begin transition, defer load the packed scene, once done we pass
##	the battlemap down to battleMapController, and then we undo the transition
func load_and_trans_battle_map():
	pass

##this function is called when the user clicks a battle on the map
## [] it will initiate the screen transition, and then make the world map invisible
## [] then defer load the battle_map into a node instead of a packed scene
## [] then we make the battlemap visible call the function to add the new battlemap
## [] wait for battlemap init to be done (use a signal I imagine)
## [] then we end transition, and send a functino down to the battle screen to start
## 		the battle.
func _on_world_map_controller_map_node_clicked(battle_map: PackedScene) -> void:
	print("game.gd debug")
	trans_node.begin_transition()
	
	await trans_node.trans_finished
	
	world_map_control.visible = false
	battle_screen_control.visible = true
	
	trans_node.end_transition()
	await trans_node.trans_finished
	##battle_screen_control.start_battle()
	
	##var node = battlemap.instant


##Mouse Input Handling
##	NOTE (This should be moved down a node to battleScreen Controller where it can handle
##		  the mouse input for abilities, and other things)
##	[]We need to first detect if the mouse in hovering over the subviewport
##	[]If it is we need to pass the mouse input down to the battle map
##	[]else the buttons and such should handle the input themselves
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		var pos = event.global_position
		if sub_view_rect.has_point(pos):
			##send input mouse position down to the BattleController
			pass
