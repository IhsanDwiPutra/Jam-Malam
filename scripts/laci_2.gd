extends CSGCombiner3D

var is_open = false

@onready var anim = $"../AnimationPlayer"

func interact(player):
	if is_open:
		tutup_laci()
	else:
		buka_laci()

func tutup_laci():
	is_open = false
	anim.play_backwards("buka_laci")

func buka_laci():
	is_open = true
	anim.play("buka_laci")
