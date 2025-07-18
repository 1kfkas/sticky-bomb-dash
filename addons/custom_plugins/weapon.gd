@tool
extends CharacterBody2D

@export_category("Recursos Necessários")
@export var sprite: Sprite2D
@export var bulletPosition: Marker2D

@export_category("Recursos Opcionais")
@export var intervalo: Timer

@export_category("Estados")
@export_enum("NONE", "PLAYER", "ENEMY") var holding: int = 0
@export var holdTrigger: bool = false

var bullet: Resource = preload("res://Enemys/Bullet.tscn")

var flip_v: float = 1.0

func _enter_tree() -> void:
	z_index = 1

func _process(delta: float) -> void:
	match(holding):
		
		#CASO NÃO TENHA NINGUÉM SEGURANDO A ARMA
		0:
			pass
		
		#CASO O PLAYER ESTEJA SEGURANDO A ARMA
		1:
			if Global.player:
				# Animação da arma
				
				var mouse_pos = get_global_mouse_position()
				
				rotation = Global.player.global_position.angle_to_point(mouse_pos)
				position = Global.player.position + Vector2(cos(rotation)*8, sin(rotation)*8) 
				
				if mouse_pos.x >= position.x:
					flip_v = lerpf(flip_v, 1.0, 10 * delta)
				else:
					flip_v = lerpf(flip_v, -1.0, 10 * delta)
				
				sprite.scale.y = flip_v
				
				# Atirar projétil
				
				if holdTrigger:
					pass
				else:
					if Input.is_action_just_pressed("action"):
						var bulletInstance = bullet.instantiate()
						bulletInstance.direction = rotation
						bulletInstance.position = bulletPosition.global_position
						get_tree().current_scene.add_child(bulletInstance)
		
		#CASO O INIMIGO ESTEJA SEGURANDO A ARMA
		2:
			pass
