class_name AbilityBase extends Resource

enum TARGET_TYPE {
	SELF,
	SINGLE,
	AREA
}

@export var ability_name: String = ""
@export var ability_desc: String = ""
@export var target_type: TARGET_TYPE = TARGET_TYPE.SINGLE
@export var abi_range: int = 1

##Used for damage, or healing
@export var val: int = 0

func effect(target_unit: UnitBase, caster: UnitBase):
	pass

func get_range():
	return abi_range

func get_tiles():
	return []
