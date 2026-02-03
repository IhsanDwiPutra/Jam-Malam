extends Node3D

@onready var audio = $AudioStreamPlayer3D

@export_enum("kamar", "pagar") var tipe_kunci = "kamar"

func interact(player):
	if tipe_kunci == "kamar":
		player.punya_kunci_kamar = true
		player.update_misi("Misi: Cari kamar Dani")
		audio.play()
		visible = false
		await audio.finished
		queue_free()
		
