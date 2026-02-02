extends StaticBody3D

var is_open = false

func interact():
	if is_open:
		tutup_pintu()
	else:
		buka_pintu()

func
