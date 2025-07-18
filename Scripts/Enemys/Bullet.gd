extends Sprite2D

@export var direction: float = 0.0
@export var speed: float = 500.0

@onready var particles = $GPUParticles2D

func _process(delta: float) -> void:
	position += Vector2(cos(direction), sin(direction)) * speed * delta
	rotation = direction
	
	if Global.camera.position.distance_to(position) > 750.0:
		destroy()

func _on_area_2d_body_entered(body: Node2D) -> void:
	destroy()

func destroy() -> void:
	Global.shake = 10.0
	particles.emitting = true
	particles.reparent(get_tree().current_scene)
	call_deferred("queue_free")
