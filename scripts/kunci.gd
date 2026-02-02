extends CSGCombiner3D

@onready var audio = $"../AudioStreamPlayer3D"


func interact(player):
	print("Kunci diambil!")
	player.has_key = true
	
	player.update_misi("Misi: Buka Kamar 04 di Lantai 2")
	
	audio.play()
	visible = false
	await audio.finished
	
	queue_free()
