class_name BattleMapNode extends Node2D


@onready var main_tile: TileMapLayer = $MainTile
@onready var unit_container: Node2D = $EnemyUnits

@export var placeable_tiles: Array[Vector2i]
var map_node: MapNode ##set on battle map instantiation

func get_enemy_units():
	return unit_container.get_children()
