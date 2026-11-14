extends AbilityBase


func effect(target_unit: UnitBase, caster: UnitBase):
	super(target_unit, caster)
	target_unit.take_damage(val)

func get_tiles():
	var r = abi_range
	var out = []
	for x in range(r * -1, r + 1):
		for y in range(r * -1, r + 1):
			var axy = abs(x) + abs(y)
			
			if axy <= r and axy != 0:
				out.append(Vector2i(x,y))
	
	return out
