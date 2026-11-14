
extends CharacterBody2D

var acceleration = 800.0
var max_speed = 120.0
var friction = 500.0
@onready var background = $TavernBackground

enum {IDLE, RUN}
var state = IDLE

@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree["parameters/playback"]
@onready var key_spawn = get_parent().get_node("KeySpawn")

@export var key_scene: PackedScene

var blend_position: Vector2 = Vector2.DOWN

var blend_pos_paths = [
	"parameters/idle/idle_bs2d/blend_position",
	"parameters/run/run_bs2d/blend_position"
]
var animTree_state_keys = [
	"Idle",
	"Run"
]

var animTree_state_keys = [
	"Idle",
    "Run"
]

var days = 1
var day_length = 300.0
var time_passed = 0.0


func _ready() -> void:
	animationTree.active = true


func _physics_process(delta: float) -> void:
	move(delta)
	animate()

func move(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func _process(delta: float) -> void:
	time_passed += delta

	if time_passed >= day_length:
		time_passed -= day_length
		days += 1

		print("Day ", days)

		if days > 2:
			spawn_key()


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
		background.visible = true
		$Ground.visible = false

		body.get_node("AnimatedSprite2D").scale = Vector2(10, 10)
		body.get_node("Camera2D").zoom = Vector2(0.2, 0.2)

		body.acceleration = 8000.0
		body.max_speed = 1200.0
		body.friction = 5000.0
