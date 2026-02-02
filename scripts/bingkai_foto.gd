extends MeshInstance3D

@export var painting : StandardMaterial3D

func _ready():
	material_override = painting
