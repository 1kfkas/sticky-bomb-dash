@tool
extends Node2D

func _process(delta: float) -> void:
	if Global.camera and Global.player:
		if get_parent().global_position.x < Global.player.position.x and Global.camera.global_position.distance_to(global_position) >= 480:
			owner.queue_free()
