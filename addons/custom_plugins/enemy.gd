@tool
extends CharacterBody2D

@export var move: bool = false
@export var moveSpeed: float = 100.0
@export var hitbox: Area2D
@export var scorable: bool = false

@onready var deathParticles: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	velocity = Vector2(0.0, 0.0)
		
func killYourself() -> void:
	Global.shake = 15.0
	Global.score += 50
	deathParticles.emitting = true
	deathParticles.reparent(get_tree().current_scene)
	call_deferred("queue_free")

func _physics_process(delta: float) -> void:
	if !Engine.is_editor_hint():
		if Global.player and move and global_position.x - Global.player.global_position.x <= 200:
			velocity.x = -moveSpeed
		
		if not is_on_floor():
			velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity")
		
		move_and_slide()
