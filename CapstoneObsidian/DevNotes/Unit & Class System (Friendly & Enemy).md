
Abstract:
Units in the game need to be able to exist on an isometric grid(have coordinates), and we will go ahead and add support for height. They need to have a dedicated class (described below) that class will determine, and be the source, of the characters stats and their available abilities. 

There are certain stats that need to exist for purposes of debuffs, here is a list of all the currently needed stats, and debuffs, and their default values:
	Health - See Class
	Mana - See Class
	Mana Recovery - See Class
	Health Recovery - 0
	Guard - 0 (flat damage reduc)
	Damage Mod - 1.0 (IE a 5% increase would go to 1.05)
	Hit Chance Mod - 1.0
	Cast Chance Mod - 1.0
	Attack Chance Mod - 1.0 (effects both hit and cast)
	(Add more as needed)

There are two melee, and two ranged classes (there will be variants for main characters and bosses)

First the melees:

DPS
//Choose a name besides knight me thinks, knight sounds too tanky for this archetype
Knight - 
	Stats : Health - 100 | Mana - 30 | Mana Recovery - 10 / turn
	Abilities:
		Strike (basic): 
			Effect - Strike a target in the immediate vicinity, dealing damage
			Range - 1 immediate tile single target
			Damage - 30 - 35
			Mana Cost - 0
		  Cleave:
			  Effect - Cleave your blade in an arc, hitting the 3 tiles in front of you
			  Range - 1 immediate tile, hitting the 3 tiles in that direction
			  Damage - 15 - 20
			  Mana Cost - 20
		  Embolden:
			  Effect - Empower yourself in preparation for your next turn, granting you bonus damage (2x)
			  Range - 0 (self cast)
			  Damage - 0 - 0 (grants effect that doubles the damage of your attack next turn)
			  Mana Cost - 30
		  PlaceH:


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
		Radiant Light:
			Effect - Blind enemy target, or heal a friendly target
			Range - 7 tiles, single target
			Blind - Inflicts target with a 50% chance to miss their next attack
			Heal - 
			Mana Cost - 35
			

Now the ranged

DPS
Wizard - 
	Stats: Health - 60 | Mana - 75 | Mana Recovery - 15 / turn
	Abilities:
		Zap (Strike):
			Effect - Emit a long ranged arc of electricity from your staff, hitting a target enemy
			Range - 6 tiles, single target
			Damage - 10 - 15
			Mana Cost - 0
		Summon Lightning: 
			Effect - Isolate a collection of static electricity above target opponent, summoning a bolt of lightning onto them.
			Range - 6 tiles
			Damage - 45 - 50
			Mana Cost - 50
		Eradication:
			Effect - Summon a vortex to a plane of pure entropy, originating inside the chest of target enemy.
			Range - 1 tile, Single target
			Damage - 60 - 120
			Mana Cost - 75

SUPPORT
(Crossbow and Buff / Debuff bombs)
Bombardier -
	Stats: Health - 80 | Mana - 50 | Mana Recovery - 10 / turn
	Abilities: 
