class_name UnitBase extends Node2D
signal unit_died()

##subnodes
@onready var blood_particle: GPUParticles2D = $Node2D

@export var unit_name: String = "Enter Name..."
@export var unit_class : UnitClass
@export var portrait_texture: Texture2D
@export var is_ally: bool

var damage_mod: float = 1.0
var hit_chance_mod: float = 1.0
var cast_chance_mod: float = 1.0
var attack_change_mode: float = 1.0
var turn_order_pos: int = -1
var unit_dead: bool = false

##holds the units target position, the unit will lerp to it when moving
var map_position: Vector2i = Vector2i(0, 0)
@export var starting_pos: Vector2i = Vector2i(0, 0)

@export_category("Battle Stats")
@export var health: int = 100
@export var max_health: int = 100
@export var mana: int = 0
@export var mana_recovery: int = 0
@export var movement_left: int = 3



@export_category("Strike / Abilities")
@export var strike: AbilityBase
@export var chosen_ability: AbilityBase
@export var available_abilities: Array[AbilityBase]
##Dictates the number of abilities a unit can use in a turn
@export var ability_use_left: int = 1
@export var max_ability_uses: int = 1

#For now each unit will just have a static sprite
#	In the future I want them to be animated
@export var sprite: Texture2D
@onready var sprite_node: Sprite2D = $Sprite2D
@onready var grave: Sprite2D = $GraveSprite
@onready var death_anim: AnimatedSprite2D = $AnimatedSprite2D

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

func take_damage(val: int):
	if unit_dead:
		return
	
	health -= val
	
	blood_particle.restart(false)
	
	health = max(health, 0)
	
	await blood_particle.finished
	if health <= 0:
		die()

func heal(val: int):
	if unit_dead: return
	
	health += val
	
	health = min(health, max_health)

func die():
	if not unit_dead:
		unit_dead = true
		death_anim.play()


func get_strike():
	if strike != null:
		return strike
	else:
		return null

func can_use_ability():
	if ability_use_left > 0:
		return true
	else:
		return false

func reset_turn():
	movement_left = 3
	ability_use_left = max_ability_uses


func hide_sprite():
	sprite_node.visible = false

func show_sprite():
	pass


func _on_animated_sprite_2d_frame_changed() -> void:
	if death_anim.frame == 7:
		hide_sprite()

func _on_animated_sprite_2d_animation_finished() -> void:
	death_anim.stop()
	death_anim.frame = 0
	grave.visible = true
