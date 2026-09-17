class_name BattleMapNode extends Node2D


@onready var main_tile: TileMapLayer = $MainTile
@onready var unit_container: Node2D = $EnemyUnits

func get_enemy_units():
	return unit_container.get_children()
