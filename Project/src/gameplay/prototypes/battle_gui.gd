class_name BattleGUI extends Control
signal placement_done()

@onready var portrait_gui: TextureRect = $Portrait
@onready var movement_left_display: Control = $MovementLeftDis
@onready var health_label: Label = $HealthLabel
@onready var active_button: Control = $ActiveUnitButtonCtr
@onready var attack_indicator: AnimatedSprite2D = $Portrait/AnimatedSprite2D

@onready var placement_container: VBoxContainer = $PlacementCont

var placeables: Array = []

func update_gui(new_char: UnitBase, battle_phase: BattleScreen.BATTLE_PHASES, turn_state: BattleScreen.TURN_STATES):
	portrait_gui.texture = new_char.portrait_texture
	movement_left_display.update(new_char.movement_left)
	health_label.text = str(new_char.health) + "/" + str(new_char.max_health)
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
func update_placement():
	attack_indicator.visible = false
	
	for child in placement_container.get_children():
		child.queue_free()
	
	if placeables == []:
		placement_done.emit()
	
	if len(placeables) == 1:
		##place the solo tile, into place_cont 
		return
	
	##place the start tile, into place_cont with placeables[0]
	
	for i in range(1, len(placeables) - 1):
		##place the middle tile, into placeable with all placeable[i]
		pass
	
	##place the end tile into place_cont with placeables[len(placeables) - 1]

func set_placeables(to: Array):
	placeables = to
