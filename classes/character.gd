class_name Character
extends Node3D
@export var skill_points :int
@export var health_bar: ProgressBar
@export var health :int = 100:
	set(value):
		health = value
		health_bar.value = health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skill_points = 0
	health = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
