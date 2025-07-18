extends Camera2D

@onready var markerLimit: Marker2D = $Marker2D
var markerInitialX: float

@export var player: CharacterBody2D;

func _ready() -> void:
	Global.camera = self
	
	markerInitialX = markerLimit.position.x
	
	var playerNode = get_tree().get_nodes_in_group("Player");
	
	if playerNode:
		player = playerNode[0];

func _process(delta: float) -> void:
	if player:
		position = player.position + Vector2(100.0, 0);
	
	markerLimit.position.x = markerInitialX * zoom.x
