Create a modular system, that utilizes a shape, range and various other flags to determine the effect
the can_effect function should take in an array of all units in range and return an array of all the units it can affect based on the flags

NOTE: if we add status effects, then abilities will apply those

Finally each ability will override the abstract function effect()
and effect will be custom for each ability


Some potential flags to keep in mind:
affect_self
affect_ally
affect_enemy
range
shape


some potential functions
get_range() : returns a raw range int
get_shape() : returns a bitmap of the shape of the effect

get_effectable(units:array\[UnitBase]) : checks every unit in the array against our flags to get effectable ones
apply_effect(units:array\[UnitBase]) will take in an array of units (already cut to ones we need) and apply an effect to each one. This will be custom to each ability

