extends Node
@export var camera: Camera3D
@export var attack_button: Button
@export var defend_button: Button
@export var player: Node3D
@export var enemy: Node3D
@export var enemy_cd: Timer
const init_cam_pos = Vector3(2.15, 1.04, 4.86)
const player1_cam_pos = Vector3(1.185, 0.921, 1.723)
const cam_rotation = Vector3(0.0, 4.6, 0.0)
enum turn {Player, Enemy}
@export var current_turn :turn:
	set(value):
		current_turn = value
		if current_turn == turn.Player:
			print("Player turn")
			cam_tween(player1_cam_pos, cam_rotation)
		elif current_turn == turn.Enemy:
			print("Enemy turn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	current_turn = turn.Player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass


func _on_attack_button_pressed() -> void:
	attack_button.disabled = true
	defend_button.disabled = true
	await cam_tween(init_cam_pos, Vector3(0.0, 0.0, 0.0))
	await get_tree().create_timer(0.1).timeout
	print("Attack!")
	var damage = randi_range(10, 15)
	enemy.health -= damage
	current_turn = turn.Enemy
	enemy_cd.start()


func _on_enemy_cd_timeout() -> void:
	print("Enemy making turn")
	var damage = randi_range(9, 12)
	player.health -= damage
	await get_tree().create_timer(0.5).timeout
	current_turn = turn.Player
	attack_button.disabled = false
	defend_button.disabled = false
	
func cam_tween(final_pos, final_rotation_deg) -> void:
	var camTween = self.create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE).set_parallel()
	camTween.tween_property(camera, "position", final_pos, 1.0)
	camTween.tween_property(camera, "rotation_degrees", final_rotation_deg, 1.0)
	await camTween.finished
