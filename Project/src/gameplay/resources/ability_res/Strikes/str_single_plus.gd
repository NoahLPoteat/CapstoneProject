extends AbilityBase


func effect(target_unit: UnitBase, caster: UnitBase):
	super(target_unit, caster)
	target_unit.take_damage(val)

func get_tiles():
	var r = abi_range
	var out = [] 
	for x in range(r * -1, r + 1):
		for y in range(r * -1, r + 1):
			var ax = abs(x)
			var ay = abs(y)
			var axy = ax + ay
			
			if (ax == 0 or ay == 0) and axy <= r:
				out.append(Vector2i(x,y))
			
	return out
