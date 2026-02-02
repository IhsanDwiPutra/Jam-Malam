extends CSGCombiner3D

var is_open = false

@onready var anim = $"../AnimationPlayer"
@onready var audio_player = $"../AudioStreamPlayer3D"

@export var sfx_buka : AudioStream
@export var sfx_tutup : AudioStream

func interact(player):
	if is_open:
		tutup_laci()
	else:
		buka_laci()

func tutup_laci():
	is_open = false
	anim.play_backwards("buka_laci")
	play_sound(sfx_tutup)

func buka_laci():
	is_open = true
	anim.play("buka_laci")
	play_sound(sfx_buka)

func play_sound(suara):
	if suara:
		audio_player.stream = suara
		audio_player.pitch_scale = randf_range(0.9, 1.1)
		audio_player.play()
	
	
