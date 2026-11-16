class_name AbiSlectionContainer extends Control
signal abi_selected(choice: options)

#TODO:
# ability_changed function
#	make the active button whichever one is the users selected ability
# button_1 clicked function
#	change the current units ability to button1
# button_2 clicked function
#	change current units ability to button2
# update_info function
#	Update name label
#	Update desc label
#	TODO:
#		modify update info to have extra info (damage, heal vs harm, single aoe, self)

@onready var abi_1_bg_on : TextureRect  = $AbiButtonCont1/BgOn
@onready var abi_1_bg_off : TextureRect = $AbiButtonCont1/BgOff
@onready var abi_2_bg_on : TextureRect  = $AbiButtonCont2/BgOn
@onready var abi_2_bg_off : TextureRect = $AbiButtonCont2/BgOff

@onready var name_label : Label     = $AbiNameLabel
@onready var desc_label : Label     = $AbiDescLabel
@onready var abi_icon : TextureRect = $AbiButtonCont1/AbiIcon

var active_abi_1: AbilityBase
var active_abi_2: AbilityBase

var active_button: options = options.ABI_ONE
enum options{
	ABI_ONE,
	ABI_TWO
}


##Check op 1 and op 2 and set them as the active ones
func update_ability_options(ability_options: Array[AbilityBase]):
	if ability_options.size() != 2: print("Unit lacks two abilities"); return;
	active_abi_1 = ability_options[0]
	active_abi_2 = ability_options[1]
	active_button = options.ABI_ONE
	abi_1_bg_off.visible = false 
	abi_1_bg_on.visible  = true
	abi_2_bg_off.visible = true
	abi_2_bg_on.visible  = false
	update_info()


func update_info():
	#update name label
	var to_name: String 
	var to_desc: String
	match active_button:
		options.ABI_ONE:
			to_name = active_abi_1.ability_name
			to_desc = active_abi_1.ability_desc
		options.ABI_TWO:
			to_name = active_abi_2.ability_name
			to_desc = active_abi_2.ability_desc
		_:
			to_name = "bugged"
			to_desc = "This shouldn't be. This units ability is broken."
	
	name_label.text = to_name
	desc_label.text = to_desc

func on_button_1_pressed():
	active_button = options.ABI_ONE
	abi_1_bg_off.visible = false 
	abi_1_bg_on.visible  = true
	abi_2_bg_off.visible = true
	abi_2_bg_on.visible  = false
	update_info()
	abi_selected.emit(options.ABI_ONE)

func on_button_2_pressed():
	active_button = options.ABI_TWO
	abi_1_bg_off.visible = true 
	abi_1_bg_on.visible  = false
	abi_2_bg_off.visible = false
	abi_2_bg_on.visible  = true
	update_info()
	abi_selected.emit(options.ABI_TWO)


func _on_mouse_detect_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event:
		on_button_1_pressed()


func _on_mouse_detect_input_event_abi_2(viewport, event, shape_idx):
	if event is InputEventMouseButton and event:
		on_button_2_pressed()
