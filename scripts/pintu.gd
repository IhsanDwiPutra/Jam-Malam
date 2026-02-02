extends Node3D
var is_open = false

@onready var anim = $AnimationPlayer
@onready var audio_player = $AudioStreamPlayer3D

@export var is_locked = false 
@export var sfx_buka : AudioStream
@export var sfx_tutup : AudioStream
@export var sfx_terkunci : AudioStream

func interact(player):
	if is_locked:
		if player.has_key == true:
			print("Pintu terbuka dengan kunci!")
			is_locked = false
			play_sound(sfx_buka)
			buka_pintu()
		else:
			print("Pintu terkunci. Cari kuncinya dulu.")
			play_sound(sfx_terkunci)
	else:
		if is_open:
			play_sound(sfx_tutup)
			tutup_pintu()
		else:
			play_sound(sfx_buka)
			buka_pintu()

func tutup_pintu():
	is_open = false
	anim.play("close_door")

func buka_pintu():
	is_open = true
	anim.play("open_door")

func play_sound(suara):
	if suara:
		audio_player.stream = suara
		audio_player.pitch_scale = randf_range(0.9, 1.1)
		audio_player.play()
