extends CSGCombiner3D

var sudah_ketrigger = false

@onready var suara = $"../AudioStreamPlayer3D"

func interact(player):
	print("Mengambil Kunci")
	suara.play()
	player.has_key = true
	player.update_misi("Misi: KABUR LEWAT PINTU DEPAN")
	
	queue_free()
