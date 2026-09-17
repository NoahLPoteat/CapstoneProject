extends Control

@onready var trans_node: ScreenTransitionHandler = $TransitionNode
@onready var battle_screen_control = $BattleScreenController
@onready var world_map_control: WorldMapController = $WorldMapController



##this function is called when the user clicks a battle on the map
## [X] it will initiate the screen transition, and then make the world map invisible
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
