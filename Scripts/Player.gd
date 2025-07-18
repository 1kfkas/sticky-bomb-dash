extends CharacterBody2D

@export var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var maxSpeed: float = 200.0;
@export var acceleration: float = 2.0;

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: CollisionShape2D = $Hurtbox;

func _ready() -> void:
	Global.player = self
	
	velocity.x = 100.0;
	$AnimatedSprite2D.play("player-idle");

func _process(delta: float) -> void:
	# Animation
	sprite.speed_scale = velocity.x/50.0
	
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y += gravity;
		sprite.pause()
	else:
		sprite.play()
		if Input.is_action_just_pressed("jump"):
			velocity.y = -400.0;
	
	var horizontal_axis = Input.get_axis("left", "right")
	
	velocity.x = horizontal_axis * maxSpeed
		
	move_and_slide();
