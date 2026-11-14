extends Node2D

@onready var background = $TavernBackground

func _on_bartrigger_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		background.visible = true
		$Ground.visible = false

		body.get_node("AnimatedSprite2D").scale = Vector2(10, 10)

		var camera = body.get_node("Camera2D")
		camera.zoom = Vector2(0.2, 0.2)
