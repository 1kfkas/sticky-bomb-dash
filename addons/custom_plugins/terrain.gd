@tool
extends TileMapLayer

@export var endingPoint: Marker2D
var spawned: bool = false

func _enter_tree() -> void:
	tile_set = preload("res://addons/custom_plugins/terrain.tres")

func _process(delta: float) -> void:
	if Global.player:
		if !spawned and Global.player.position.x > position.x:
			print("Spawnei")
			spawnTerrain()

func spawnTerrain(index: int=-1) -> void:	
	if index == -1:
		var random = RandomNumberGenerator.new()
		index = random.randi_range(0, Global.terrainsList.size()-1)

	var newTerrain: TileMapLayer = Global.terrainsList[index].instantiate()
	newTerrain.position = position + endingPoint.position
	print(newTerrain.position)
	get_tree().current_scene.add_child(newTerrain)
	spawned = true
