class_name MapContainer extends Node2D
signal need_nav

var nav_sys: AStar2D

func update_nav_mesh(new_nav: AStar2D):
	nav_sys = new_nav
