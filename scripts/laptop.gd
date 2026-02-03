extends Node3D

func interact(player):
	print("Laptop didapatkan! BAHAYA DATANG!")
	
	player.has_laptop = true
	
	player.update_misi("Misi: AMBIL KUNCI DARI IBU KOST & KABUR")
	var level_root = get_tree().current_scene
	var hantu = level_root.get_node("IbuKost")
	var bgm_chase = level_root.get_node("SFX/BGM_Chase")
	var bgm_santai = level_root.get_node("SFX/BGM_Ambience")
	
	if hantu:
		hantu.visible = true
		hantu.global_position = Vector3(2.291, -2.5, -7.207)
		player.musuh_aktif = hantu
		player.ui_jantung.visible = true
		print("Ibu kost ditemukan")
	
	if bgm_chase:
		bgm_santai.stop()
		bgm_chase.play()
	
	queue_free()
	
