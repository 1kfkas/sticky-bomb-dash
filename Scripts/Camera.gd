extends Camera2D

@onready var GameOverLayer: CanvasLayer = $"Game Over"

var rng = RandomNumberGenerator.new()
var previousX: float = position.x

func _ready() -> void:
	Global.score = 0
	get_tree().tree_changed.connect(checkPlayerDeath)
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

func checkPlayerDeath() -> void:
	if !Global.player:
		GameOverLayer.visible = true

### GUI

# Restart Button
func _on_reiniciar_button_up() -> void:
	get_tree().reload_current_scene()

#Menu Button
func _on_menu_button_up() -> void:
	get_tree().change_scene_to_packed(Global.menuScene)

#Check player entered
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner.is_in_group("Player"):
		area.owner.killYourself()
