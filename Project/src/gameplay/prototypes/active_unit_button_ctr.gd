class_name UnitButton extends Control
signal button_pressed(choice: BUTTON_CHOICE)

@onready var abiBut: TextureRect = $AbilityButtonUp
@onready var strBut: TextureRect = $StrikeButtonUp
@onready var movBut: TextureRect = $MoveButtonUp

enum BUTTON_CHOICE {
	ABILITY,
	STRIKE,
	MOVEMENT
}

func update(x: BattleScreen.TURN_STATES):
	match x:
		BattleScreen.TURN_STATES.MOVING:
			_update(BUTTON_CHOICE.MOVEMENT)
		BattleScreen.TURN_STATES.STRIKING:
			_update(BUTTON_CHOICE.STRIKE)
		BattleScreen.TURN_STATES.ABILITY:
			_update(BUTTON_CHOICE.ABILITY)

#Hide buttonUp for the button we want down
func _update(choice: BUTTON_CHOICE):
	
	match choice:
		BUTTON_CHOICE.MOVEMENT:
			abiBut.visible = true
			strBut.visible = true
			movBut.visible = false
		BUTTON_CHOICE.ABILITY:
			abiBut.visible = false
			strBut.visible = true
			movBut.visible = true
		BUTTON_CHOICE.STRIKE:
			abiBut.visible = true
			strBut.visible = false
			movBut.visible = true
		_:
			abiBut.visible = true
			strBut.visible = true
			movBut.visible = true


func _on_mov_but_detec_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event:
		button_pressed.emit(BUTTON_CHOICE.MOVEMENT)


func _on_str_but_detect_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		button_pressed.emit(BUTTON_CHOICE.STRIKE)


func _on_abi_but_detec_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		button_pressed.emit(BUTTON_CHOICE.ABILITY)
