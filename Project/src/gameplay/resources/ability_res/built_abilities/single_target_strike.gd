extends AbilityBase




func effect(target_unit: UnitBase):
	super(target_unit)
	target_unit.take_damage(val)
