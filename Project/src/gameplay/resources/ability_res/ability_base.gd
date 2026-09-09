class_name AbilityBase extends Resource

enum TARGET_TYPE {
	SELF,
	SINGLE,
	AREA
}

@export var ability_name: String = ""
@export var ability_desc: String = ""
@export var targert_type: TARGET_TYPE
