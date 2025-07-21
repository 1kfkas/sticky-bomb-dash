extends Sprite2D

@export var direction: float = 0.0
@export var speed: float = 500.0

@onready var particles = $GPUParticles2D

func _process(delta: float) -> void:
	position += Vector2(cos(direction), sin(direction)) * speed * delta
	rotation = direction
	
	if Global.camera.position.distance_to(position) > 750.0:
		killYourself()

func _on_area_2d_body_entered(_body: Node2D) -> void:
	killYourself()

func killYourself() -> void:
	Global.shake = 10.0
	particles.emitting = true
	particles.reparent(get_tree().current_scene)
	call_deferred("queue_free")

func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area)
	if area.owner.is_in_group("Enemy") or area.owner.is_in_group("Projetil"):
		area.owner.killYourself()
		killYourself()
