extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		if body.has_laptop == true:
			print("Tamat")
			
			call_deferred("menang")

func menang():
	await get_tree().create_timer(1.0).timeout
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
