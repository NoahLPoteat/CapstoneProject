
Abstract:
Units in the game need to be able to exist on an isometric grid(have coordinates), and we will go ahead and add support for height. They need to have a dedicated class (described below) that class will determine, and be the source, of the characters stats and their available abilities. 

There are certain stats that need to exist for purposes of debuffs, here is a list of all the currently needed stats, and debuffs, and their default values:
	Health - See Class
	Mana - See Class
	Mana Recovery - See Class
	Health Recovery - 0
	Guard - 0 (flat damage reduc)
	Damage Mod - 1.0 (IE a 5% increase would go to 1.05)

There are two melee, and two ranged classes (there will be variants for main characters and bosses)

First the melees:

DPS
//Choose a name besides knight me thinks, knight sounds too tanky for this archetype
Knight - 
	Stats : Health - 100 | Mana - 30 | Mana Recovery - 10 / turn
	Abilities:
		Strike: 
			Effect - Strike a target in the immediate vicinity, dealing damage
			Range - 1 immediate tile single target
			Damage - 30 - 35
			Mana Cost - 0
		  


SUPPORT
Cleric -
	Stats: Health - 125 | Mana 60 | Mana Recovery - 15 / turn
	Abilities:
		Goad:
			Effect - Produce a flash of holy light from your shield, taunting those in your immediate vicinity (3x3 centered around you or 1 tile). Goaded enemies may only use their basic attack on you, but they deal 5% more damage.
			Range - 1 tile
			Damage - 0 - 0
			Mana Cost - 30
			Duration - 1 Turn
		Radiant Light

Now the ranged

DPS
Wizard - Health - 60 | Mana - 75 | Mana Recovery - 20 / turn
	Stats: Health
	Abilities:


SUPPORT
(Crossbow and Buff / Debuff bombs)
Bombardier -
	Stats: Health - 80 | Mana - 50 | Mana Recovery - 10 / turn
	Abilities:
