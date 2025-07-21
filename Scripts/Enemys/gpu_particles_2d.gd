extends GPUParticles2D

func _on_finished() -> void:
	call_deferred("queue_free")
