extends Control

@onready var trans_node: ScreenTransitionHandler = $TransitionNode
@onready var battle_screen_control = $BattleScreenController
@onready var world_map_control: WorldMapController = $WorldMapController
@onready var title_screen: TitleScreen = $TitleScreen
@onready var battle_map_control: BattleMapControl = $BattleScreenController/SubViewportContainer/SubViewport/BattleMapController
func _ready() -> void:
	##let title screen know to transition the main menu on
	get_tree().set_auto_accept_quit(false)
	title_screen.swap_to_menu_screen(TitleScreen.MENU_STATES.MAIN)
	trans_node.end_transition()

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
		
		
		
		if map_node.reward_unit_scene != null:
			##TODO:
			#instantiate reward_unit
			#add_child(reward_unit) to the players unit pool
			var to_add: UnitBase = map_node.reward_unit_scene.instantiate()
			battle_map_control.give_player_unit(to_add)
	battle_screen_control.visible = false
	battle_screen_control.unload_map()
	
	world_map_control.visible = true
	
	trans_node.end_transition()
	await trans_node.trans_finished

##go back to main menu
func back_to_menu():
	pass

func _on_title_screen_start_game() -> void:
	##TODO:
	##	trans.begin
	##	title_screen vis off
	##	world map vis on
	##	trans.end
	trans_node.begin_transition()
	await trans_node.trans_finished
	title_screen.visible = false
	world_map_control.visible = true
	trans_node.end_transition()
	await trans_node.trans_finished

func close_game():
	trans_node.begin_transition()
	await trans_node.trans_finished
	get_tree().quit()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		trans_node.begin_transition()
		await trans_node.trans_finished
		get_tree().quit()
