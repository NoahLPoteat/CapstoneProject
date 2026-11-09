class_name AdvancedAbility extends AbilityBase

@export var affect_self : bool = false
@export var affect_enemy: bool = false
@export var affect_ally : bool = false
@export var shape : Array[Vector2i]
@export var range_shape : Array[Vector2i]

func get_tiles():
	return range_shape

func get_shape():
	return shape

func get_effectable(caster: UnitBase, targets: Array[UnitBase]):
	var out_array = []
	
	if affect_self: out_array.append(caster)
	
	for unit in targets:
		var is_ally: bool = caster.is_ally == unit.is_ally
		
		if affect_ally and is_ally:
			out_array.append(unit)
		if affect_enemy and not is_ally:
			out_array.append(unit)
	
	return out_array

func apply_effect_to_list(targets: Array[UnitBase]):
	for unit in targets: effect(unit)
