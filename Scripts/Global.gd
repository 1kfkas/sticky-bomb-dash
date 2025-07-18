extends Node

@export var terrainsList: Array[PackedScene] = [
	preload("res://Scenes/Terrains/StraightTerrain.tscn"),
	preload("res://Scenes/Terrains/UpTerrain.tscn")
]
@export var player: CharacterBody2D
@export var camera: Camera2D
