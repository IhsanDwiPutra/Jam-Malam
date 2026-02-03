extends Node3D

@export var is_interact = false
@export var target_marker : Marker3D

@onready var suara = $SfxNaik

func interact(player):
	if is_interact:
		print("Memanjat masuk lewat jendela...")
		player.set_physics_process(false)
		await player.fade_out()
		if target_marker:
			player.global_position = target_marker.global_position
			player.rotation.y = target_marker.rotation.y
			
			await get_tree().create_timer(0.5).timeout
			suara.play()
			await player.fade_in()
			player.set_physics_process(true)
			player.update_misi("Misi: Cari Kamar Dani")
			is_interact = false
