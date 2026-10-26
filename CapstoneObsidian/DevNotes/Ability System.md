Create a modular system, that utilizes a shape, range and various other flags to determine the effect
the can_effect function should take in an array of all units in range and return an array of all the units it can affect based on the flags

Finally each ability will override the abstract function effect()
and effect will be custom for each ability


Some potential flags to keep in mind:
affect_self
affect_ally
affect_enemy
range
shape
