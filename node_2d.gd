extends Node2D

@onready var background = $Bar

@export var new_background: Texture2D

func _on_background_trigger_body_entered(body):
	if body is CharacterBody2D:
		background.texture = new_background


func _on_bartrigger_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
