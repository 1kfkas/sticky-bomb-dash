@tool
extends TileMapLayer

@export var endingPoint: Marker2D
var spawned: bool = false
var cacheTerrainList: Array

var terrainsList: Array[PackedScene] = [
	load("res://Scenes/Terrains/TerrenoReto.tscn"),
	load("res://Scenes/Terrains/TerranoCima.tscn"),
	load("res://Scenes/Terrains/TerrenoZig.tscn")
]

func _enter_tree() -> void:
	tile_set = preload("res://addons/custom_plugins/terrain.tres")

func _process(delta: float) -> void:
	if Global.player:
		if !spawned and Global.player.position.x > position.x:
			spawnTerrain()

func spawnTerrain(index: int=-1) -> void:	
	if index == -1:
		index = randi_range(0, terrainsList.size()-1)
#
	var newTerrain: TileMapLayer = terrainsList[index].instantiate()
	newTerrain.position = position + endingPoint.position
	get_tree().current_scene.add_child(newTerrain)
	spawned = true
