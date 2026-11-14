class_name AdvancedAbility extends AbilityBase

@export var affect_self : bool = false
@export var affect_enemy: bool = false
@export var affect_ally : bool = false
@export var shape : Array[Vector2i]
@export var mana_cost: int = 0

##over ridden by the abilities themselves
##	do math to make shape
func get_tiles():
	return []

##consider updating this to be math based too
func get_shape():
	return []


func get_effectable(caster: UnitBase, targets: Array[UnitBase]) -> Array[UnitBase]:
	var out_array: Array[UnitBase] = []
	
	if affect_self: out_array.append(caster)
	
	for unit in targets:
		var is_ally: bool = caster.is_ally == unit.is_ally
		
		if affect_ally and is_ally:
			out_array.append(unit)
		if affect_enemy and not is_ally:
			out_array.append(unit)
	
	return out_array
