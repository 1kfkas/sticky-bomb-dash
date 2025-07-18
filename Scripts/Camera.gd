extends Camera2D

@onready var markerLimit: Marker2D = $Marker2D

var rng = RandomNumberGenerator.new()
var previousX: float = position.x

func _ready() -> void:
	rng.randomize()
	Global.camera = self

func _process(delta: float) -> void:
	if Global.player:
		if Global.player.position.x > previousX:
			position.x = Global.player.position.x;
			previousX = position.x
		
		position.y = Global.player.position.y
		
		var playerFactor: float = 0.0
		zoom = Vector2(1.0 - playerFactor, 1.0 - playerFactor)
	
	if Global.shake > 0.0:
		Global.shake -= 10 * delta
	
	var mouseViewport = get_viewport().get_mouse_position()
	
	var shakeVector = Vector2(rng.randf_range(-Global.shake, Global.shake), rng.randf_range(-Global.shake, Global.shake))
	var dinamicVector = Vector2(mouseViewport.x/2.0, (mouseViewport.y-100.0)/1.5)
	offset = shakeVector + dinamicVector
	
