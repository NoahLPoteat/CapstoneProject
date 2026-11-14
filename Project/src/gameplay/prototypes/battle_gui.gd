class_name BattleGUI extends Control
signal placement_done()

@onready var portrait_gui: TextureRect = $Portrait
@onready var movement_left_display: Control = $MovementLeftDis
@onready var health_label: Label = $HealthLabel
@onready var mana_label: Label = $ManaLabel
@onready var active_button: Control = $ActiveUnitButtonCtr
@onready var attack_indicator: AnimatedSprite2D = $Portrait/AnimatedSprite2D
@onready var abi_selection: Control = $AbiSelection

@onready var placement_container: VBoxContainer = $PlacementCont

@export var solo_cont: PackedScene
@export var start_cont: PackedScene
@export var mid_cont: PackedScene
@export var end_cont: PackedScene

var placeables: Array = []

func update_gui(new_char: UnitBase, battle_phase: BattleScreen.BATTLE_PHASES, turn_state: BattleScreen.TURN_STATES):
	portrait_gui.texture = new_char.portrait_texture
	movement_left_display.update(new_char.movement_left)
	health_label.text = str(new_char.health) + "/" + str(new_char.max_health)
	mana_label.text = str(new_char.mana) + "/" + str(new_char.max_mana)
	if battle_phase == BattleScreen.BATTLE_PHASES.PLACEMENT:
		abi_selection.visible = true
		return
	
	abi_selection.visible = false
	
	
	active_button.update(turn_state)
	
	if new_char.ability_use_left <= 0:
		
		await attack_indicator.animation_looped
		attack_indicator.visible = false
	else:
		if attack_indicator.visible != true:
			attack_indicator.visible = true 
			attack_indicator.frame = 7

## we need to get the ally char list
## then loop through every ally char until we reach the last one
##for the first we place a tile for the start of the chain into the container
##TODO: 
##	make graphic for the chooseable abilities box
##	two boxes one for each option
##	X text area underneath for the name, range, and 'value'
##	perhaps a little graphic to display damage/healing ones
func update_placement():
	print(placeables)
	attack_indicator.visible = false
	
	for child in placement_container.get_children():
		child.queue_free()
	
	if placeables == []:
		placement_done.emit()
		return
	
	var t: TextureRect
	var sprite_box: Sprite2D
	var unit : UnitBase
	
	#if len(placeables) == 1:
		#print("In here")
		#t = solo_cont.instantiate()
		#sprite_box = t.get_child(0)
		#unit = placeables[0]
		#sprite_box.frame_coords = unit.sprite_node.frame_coords
		#placement_container.add_child(t)
		#
		#update_gui(unit, BattleScreen.BATTLE_PHASES.PLACEMENT, BattleScreen.TURN_STATES.MOVING)
		#return
	
	if len(placeables) == 1:
		t = solo_cont.instantiate()
	else:
		t = start_cont.instantiate()
	
	sprite_box = t.get_child(0)
	unit = placeables[0]
	sprite_box.frame_coords = unit.sprite_node.frame_coords
	placement_container.add_child(t)
	update_gui(unit, BattleScreen.BATTLE_PHASES.PLACEMENT, BattleScreen.TURN_STATES.MOVING)
	
	if len(placeables) == 1: return
	
	for i in range(1, len(placeables) - 1):
		##place the middle tile, into placeable with all placeable[i]
		t = start_cont.instantiate()
		sprite_box = t.get_child(0)
		unit = placeables[i]
		sprite_box.frame_coords = unit.sprite_node.frame_coords
		placement_container.add_child(t)
	
	t = end_cont.instantiate()
	sprite_box = t.get_child(0)
	unit = placeables[len(placeables) - 1]
	sprite_box.frame_coords = unit.sprite_node.frame_coords
	placement_container.add_child(t)
	##place the end tile into place_cont with placeables[len(placeables) - 1]

func set_placeables(to: Array):
	placeables = to
