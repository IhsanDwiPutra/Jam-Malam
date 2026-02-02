extends Node3D

var is_open = false

@export var is_locked = false
@export var sfx_buka : AudioStream
@export var sfx_terkunci : AudioStream

@onready var anim = $AnimationPlayer
@onready var audio_player = $AudioStreamPlayer3D

func interact(player):
	if is_locked:
		if player.has_key == true:
			buka_pagar()
			is_locked = false
		else:
			play_sound(sfx_terkunci)
	else:
		if is_open:
			tutup_pagar()
		else:
			buka_pagar()

func tutup_pagar():
	anim.play_backwards("buka")
	play_sound(sfx_buka)
	is_open = false

func buka_pagar():
	anim.play("buka")
	play_sound(sfx_buka)
	is_open = true

func play_sound(suara):
	if suara:
		audio_player.stream = suara
		audio_player.pitch_scale = randf_range(0.9, 1.1)
		audio_player.play()
