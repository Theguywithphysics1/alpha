extends CharacterBody2D

<<<<<<< HEAD
var acceleration = 800.0
var max_speed = 120.0
var friction = 500.0


enum {IDLE, RUN}
var state = IDLE

@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree["parameters/playback"]

@export var key_scene: PackedScene

var blend_pos_paths = [
	"parameters/idle/idle_bs2d/blend_position",
	"parameters/run/run_bs2d/blend_position"
]
var animTree_state_keys = [
	"Idle",
	"Run"
=======
>>>>>>> parent of f6152a6 (done)
]

var animTree_state_keys = [
	"idle",
	"run"
]

func _physics_process(delta: float) -> void:
func _physics_process(delta):
	move(delta)
	animate()

func move(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
<<<<<<< HEAD
=======
	if input_vector == Vector2.ZERO:
		state = idle
		apply_friction(FRICTION * delta)
	else:
		state = run
		apply_movement(input_vector * ACCELERATION * delta)
		blend_position = input_vector
	move_and_slide()
>>>>>>> parent of f6152a6 (done)

func spawn_key():
	var new_key = key_scene.instantiate()
	get_parent().add_child(new_key)
	new_key.global_position = key_spawn.global_position
	
func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(MAX_SPEED)

func apply_friction(amount) -> void:
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)


func _on_pickuparea_area_entered(area):
	if area.is_in_group ("key"):
		area.queue_free()
		
var days = 1
var day_length = 10.0 # 5 minutes
var time_passed = 0.0

func _process(delta: float) -> void:
func _process(delta):
	time_passed += delta

	if time_passed >= day_length:
		time_passed -= day_length
		days += 1

		print("Day ", days)

		if days > 2:
			spawn_key()
<<<<<<< HEAD


func move(delta: float) -> void:
	var input_vector = Input.get_vector(
		"ui_left", "ui_right", "ui_up", "ui_down"
	)

	if input_vector == Vector2.ZERO:
		state = IDLE
		apply_friction(friction * delta)
	else:
		state = RUN
		apply_movement(input_vector * acceleration * delta)
		blend_position = input_vector

	move_and_slide()


func apply_movement(amount: Vector2) -> void:
	velocity += amount
	velocity = velocity.limit_length(max_speed)


func apply_friction(amount: float) -> void:
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO


func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)


func spawn_key() -> void:
	if key_scene == null:
		return

	var new_key = key_scene.instantiate()
	get_parent().add_child(new_key)
	new_key.global_position = key_spawn.global_position


func _on_bartrigger_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		get_parent().get_node("TavernBackground").visible = true
		$Ground.visible = false

		body.get_node("AnimatedSprite2D").scale = Vector2(10, 10)
		body.get_node("Camera2D").zoom = Vector2(0.2, 0.2)

		body.acceleration = 8000.0
		body.max_speed = 1200.0
		body.friction = 5000.0
=======
>>>>>>> parent of f6152a6 (done)
