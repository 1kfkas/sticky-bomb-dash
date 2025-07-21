extends Control

# Play Button
func _on_play_button_button_up() -> void:
	get_tree().change_scene_to_packed(Global.gameScene)
