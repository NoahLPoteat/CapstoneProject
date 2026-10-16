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
func _on_world_map_controller_map_node_clicked(battle_map: PackedScene, map_node: MapNode) -> void:
	#print("game.gd debug")
	trans_node.begin_transition()
	
	await trans_node.trans_finished
	
	world_map_control.visible = false
	var bm_node: BattleMapNode = battle_map.instantiate()
	bm_node.map_node = map_node
	battle_screen_control.battle_map_controller.load_map(bm_node)
	battle_screen_control.visible = true
	
	
	trans_node.end_transition()
	await trans_node.trans_finished
	##battle_screen_control.start_battle()
	
	##var node = battlemap.instant


##called when the battle is over and user presses continue on the battle screen
##	(for now its instant)
func _on_battle_screen_controller_game_over(game_won: bool, battle_map: BattleMapNode) -> void:
	##begin transition away from battle
	## battle.vis = false
	##	battle.unload_map
	## worldMap.vis = true
	## if won -> worldmap.progress map 
	trans_node.begin_transition()
	
	await trans_node.trans_finished
	
	if game_won:
		var map_node: MapNode = battle_map.map_node
		
		for m_node in map_node.post_maps:
			m_node.visible = true
	battle_screen_control.visible = false
	battle_screen_control.unload_map()
	
	world_map_control.visible = true
	
	trans_node.end_transition()
	await trans_node.trans_finished
