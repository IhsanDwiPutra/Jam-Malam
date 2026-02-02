extends Node3D

var is_open = false

@onready var engesel_kiri = $EngselKiri
@onready var engsel_kanan = $EngselKanan
@onready var anim = $AnimationPlayer
@onready var audio_player = $AudioStreamPlayer3D

@export var is_locked = false
@export var sfx_buka : AudioStream
@export var sfx_tutup : AudioStream
@export var sfx_terkunci : AudioStream

func interact(player):
	if is_locked:
		if player.has_key:
			is_locked = false
			buka_pintu()
		else:
			play_sound(sfx_terkunci)
			print("Terkunci")
		return
	else:
		if is_open:
			tutup_pintu()
		else:
			buka_pintu()
			
func buka_pintu():
	anim.play("buka_pintu")
	play_sound(sfx_buka)
	is_open = true

func tutup_pintu():
	anim.play("tutup_pintu")
	play_sound(sfx_tutup)
	is_open = false

func play_sound(suara):
	if suara:
		audio_player.stream = suara
		audio_player.pitch_scale = randf_range(0.9, 1.1)
		audio_player.play()
