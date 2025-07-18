extends CharacterBody2D

@export var gravity:float = 300.0;
@export var maxSpeed: float = 200.0;
@export var acceleration: float = 50;

@onready var hurtbox: CollisionShape2D = $Hurtbox;

func _ready() -> void:
	Global.player = self
	
	velocity.x = 100.0;
	$AnimatedSprite2D.play("player-idle");

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta;
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y = -200.0;
	
	if Input.is_action_pressed("left"):
		velocity.x -= acceleration * delta;
	else:
		velocity.x += acceleration * delta;
	
	velocity.x = min(velocity.x, 1000.0);
		
	move_and_slide();
