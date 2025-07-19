extends Node

@export var score: int = 0
@export var terrainsList: Array[PackedScene] = [
	preload("res://Scenes/Terrains/StraightTerrain.tscn"),
	preload("res://Scenes/Terrains/UpTerrain.tscn"),
	preload("res://Scenes/Terrains/Zig.tscn")
]
@export var player: CharacterBody2D
@export var camera: Camera2D
@export var shake: float

func _process(delta: float) -> void:
	score+=1
