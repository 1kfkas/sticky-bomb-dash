@tool
extends CharacterBody2D

@export_category("Recursos Necessários")
@export var sprite: Sprite2D
@export var bulletPosition: Marker2D

@export_category("Recursos Opcionais")
@export var intervalo: Timer

@export_category("Estados")
@export var municao: int = 0
@export_enum("NONE", "PLAYER", "ENEMY") var holding: int = 0
@export var holdTrigger: bool = false
enum HOLDING_TYPE{NONE, PLAYER, ENEMY}

@export var canShoot: bool = true

var bullet: Resource = preload("res://Enemys/Bullet.tscn")

var flip_v: float = 1.0

func _enter_tree() -> void:
	z_index = 1

func _ready() -> void:
	if intervalo:
		intervalo.timeout.connect(changeCanShoot)

func _physics_process(delta: float) -> void:
	if !Engine.is_editor_hint():
		match(holding):
			
			HOLDING_TYPE.NONE:
				
				if is_on_floor():
					velocity.x = lerpf(velocity.x, 0, 0.1)
				else:
					rotate(PI/5.0)
					velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity")
				
				move_and_slide()
			
			HOLDING_TYPE.PLAYER:
				if Global.player:
					# Animação da arma
					
					var mouse_pos = get_global_mouse_position()
					
					rotation = Global.player.global_position.angle_to_point(mouse_pos)
					global_position = Global.player.global_position + Vector2(cos(rotation)*8, sin(rotation)*8) 
					
					if mouse_pos.x >= position.x:
						flip_v = 1.0
					else:
						flip_v = -1.0
					
					sprite.scale.y = flip_v
					
					# Atirar projétil
					
					if holdTrigger:
						pass
					else:
						if Input.is_action_just_pressed("action"):
							if municao > 0:
								var bulletInstance = bullet.instantiate()
								bulletInstance.direction = rotation
								bulletInstance.global_position = bulletPosition.global_position
								get_tree().current_scene.add_child(bulletInstance)
								#municao-=1
							else:
								velocity = Vector2(cos(rotation), sin(rotation))*500.0
								holding = HOLDING_TYPE.NONE
				else:
					holding = HOLDING_TYPE.NONE
			
			HOLDING_TYPE.ENEMY:
				if owner:
					
					if Global.player and owner.global_position.x - Global.player.global_position.x <= 200:
						rotation = owner.global_position.angle_to_point(Global.player.global_position)
					
						if Global.player.global_position.x >= global_position.x:
							flip_v = 1.0
						else:
							flip_v = -1.0
					
					global_position = owner.global_position + Vector2(cos(rotation)*8, sin(rotation)*8)
					
					if canShoot and Global.player and owner.global_position.x - Global.player.global_position.x <= 200:
						var bulletInstance = bullet.instantiate()
						bulletInstance.direction = rotation
						bulletInstance.global_position = bulletPosition.global_position
						get_tree().current_scene.add_child(bulletInstance)
						intervalo.start()
						canShoot = false
					
					sprite.scale.y = flip_v

func changeCanShoot() -> void:
	canShoot = true
