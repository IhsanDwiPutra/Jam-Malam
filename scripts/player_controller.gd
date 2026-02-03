extends CharacterBody3D

# --- Konfigurasi ---
@export var speed = 5.0
@export var jump_force = 4.5
@export var mouse_sensitivity = 0.2


# --- Referensi Node ---
@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var interaction_ray = $Head/RayCast3D
@onready var senter = $Head/SpotLight3D
@onready var label_misi = $CanvasLayer/LabelMisi
@onready var sfx_kaki = $SfxKaki
@onready var layar_hitam = $CanvasLayer/LayarHitam
@onready var ui_jantung = $CanvasLayer/IconJantung
@onready var sfx_senter = $SfxSenter

# --- Variabel ---
var original_speed
var sprint_speed = 7.0
var has_key = false
var has_laptop = false
var step_timer = 0.0
var step_interval = 0.6
var musuh_aktif = null

# --- Inventory ---
var punya_kunci_kamar = false
var punya_kunci_pagar = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	original_speed = speed
	senter.visible = false

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-80), deg_to_rad(80))
		
	if Input.is_action_just_pressed("flashlight"):
		sfx_senter.play()
		await sfx_senter.finished
		senter.visible = !senter.visible
	
	# LAYAR SENTUH
	if event is InputEventScreenDrag:
		var touch_sensitivity = 0.005
		rotate_y(deg_to_rad(-event.relative.x * touch_sensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-80), deg_to_rad(80))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		if Input.is_action_just_pressed("sprint"):
			speed = sprint_speed
		if Input.is_action_just_released("sprint"):
			speed = original_speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	if interaction_ray.is_colliding():
		var benda = interaction_ray.get_collider()
		if Input.is_action_just_pressed("interact"):
			if benda.has_method("interact"):
				benda.interact(self)
			elif benda.get_parent().has_method("interact"):
				benda.get_parent().interact(self)
			elif benda.get_parent().get_parent().has_method("interact"):
				benda.get_parent().get_parent().interact(self)
	if is_on_floor() and direction:
		step_timer += delta
		if step_timer >= step_interval:
			sfx_kaki.pitch_scale = randf_range(0.8, 1.2)
			sfx_kaki.play()
			step_timer = 0.0
	else:
		step_timer = step_interval
		
	move_and_slide()
	
	if musuh_aktif != null:
		var jarak = global_position.distance_squared_to(musuh_aktif.global_position)
		
		if jarak < 5.0:
			ui_jantung.modulate = Color.RED
			ui_jantung.scale = Vector2(1.0, 1.0) * (1.0 + sin(Time.get_ticks_msec() * 0.02) * 0.2)
		elif jarak < 12.0:
			ui_jantung.modulate = Color.YELLOW
			ui_jantung.scale = Vector2(1, 1)
		else:
			ui_jantung.modulate = Color.GREEN
			ui_jantung.visible = true

func update_misi(teks_baru):
	label_misi.text = teks_baru

func fade_out():
	var tween = create_tween()
	tween.tween_property(layar_hitam, "modulate:a", 1.0, 0.5)
	await tween.finished

func fade_in():
	var tween = create_tween()
	tween.tween_property(layar_hitam, "modulate:a", 0.0, 0.5)
	await tween.finished
