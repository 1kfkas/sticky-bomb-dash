@tool
extends EditorPlugin

func _enter_tree() -> void:
	add_custom_type("Terrain", "TileMapLayer", preload("res://addons/custom_plugins/terrain.gd"), null)
	add_custom_type("Vanish Off Camera", "Node2D", preload("res://addons/custom_plugins/vanishOffCamera.gd"), null)
	add_custom_type("Weapon", "CharacterBody2D", preload("res://addons/custom_plugins/weapon.gd"), null)

func _exit_tree() -> void:
	remove_custom_type("Terrain")
	remove_custom_type("Vanish Off Camera")
	remove_custom_type("Weapon")
