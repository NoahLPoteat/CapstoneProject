extends Control

@onready var portrait_gui: TextureRect = $Portrait
@onready var movement_left_display: Control = $MovementLeftDis
@onready var health_label: Label = $HealthLabel
@onready var active_button: Control = $ActiveUnitButtonCtr

func update_gui(new_char: UnitBase, battle_phase: BattleScreen.BATTLE_PHASES, turn_state: BattleScreen.TURN_STATES):
	portrait_gui.texture = new_char.portrait_texture
	movement_left_display.update(new_char.movement_left)
	health_label.text = str(new_char.health) + "/" + str(new_char.max_health)
	active_button.update(turn_state)
