@tool
extends CharacterBody2D

@export var move: bool = false
@export var moveSpeed: float = 100.0

func _ready() -> void:
	if move:
		velocity.x = -moveSpeed

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += 0.0
	
	move_and_slide()
