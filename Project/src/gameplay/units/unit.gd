class_name UnitBase extends Node2D

@export var unit_name: String = "Enter Name..."
@export var unit_class : UnitClass

var damage_mod: float = 1.0
var hit_chance_mod: float = 1.0
var cast_chance_mod: float = 1.0
var attack_change_mode: float = 1.0

##holds the units target position, the unit will lerp to it when moving
var map_position: Vector2i = Vector2i(0, 0)

#stats determined by class
var health: int = 0 
var mana: int = 0
var mana_recovery: int = 0

#For now each unit will just have a static sprite
#	In the future I want them to be animated
@export var sprite: Texture2D

enum DIR {
	LEFT,
	RIGHT
}

var facing: DIR = DIR.RIGHT

#Initializes all the variables that are determined by the units class
func init_class_vars():
	if unit_class == null:
		print("No class selected for unit, " + unit_name)
		return
	
	health = unit_class.cl

#Initialize
func pre_fight_init():
	pass
