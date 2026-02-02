extends CSGCombiner3D

func interact(player):
	print("Laptop didapatkan!")
	
	player.has_laptop = true
	
	player.update_misi("Misi: LARI!!! KELUAR DARI KOST")
	var level_root = get_tree().current_scene
	var bgm_chase = level_root.get_node("SFX/BGM_Chase")
	var bgm_santai = level_root.get_node("SFX/BGM_Ambience")
	
	if bgm_chase:
		bgm_santai.stop()
		bgm_chase.play()
	
	queue_free()
