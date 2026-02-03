extends Area3D

@export var pagar : Node3D

var sudah_ketrigger = false

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player" and not sudah_ketrigger:
		print("JEBAKAN AKTIF! Pagar di tutup")
		if pagar.has_method("tutup_pagar"):
			pagar.tutup_pagar()
			pagar.is_locked = true
			sudah_ketrigger = true
	
