class_name StateAttack
extends State

@export_range(1,20,0.5) var decelerate_speed : float = 5.0

@onready var walk_state: StateWalk = $"../Walk"
@onready var idle: StateIdle = $"../Idle"
@onready var sword_sfx: AudioStreamPlayer2D = $"../../SwordSFX"


var isAttacking: bool = false

func Enter() -> void:
	
	isAttacking = true
	sword_sfx.play()
	play_attack_animation()

func Physics(_delta: float) -> State:
	player.direction = get_input()
	player.velocity -= player.velocity * decelerate_speed * _delta
	player.move_and_slide()
	
	if !isAttacking:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk_state
		

	return null

func get_input() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

func play_attack_animation():
	var dir = player.last_direction
	var sprite = player.sprite
	var att_fx = player.att_fx_sprite
	
	att_fx.visible = true

	if abs(dir.x) > abs(dir.y):
		sprite.animation = "attack_side"
		att_fx.animation = "att_fx_horizontal"
		att_fx.flip_v = false
		sprite.flip_h = dir.x < 0
		att_fx.flip_h = dir.x < 0
	elif dir.y > 0:
		sprite.animation = "attack_down"
		att_fx.animation = "att_fx_vertical"
		att_fx.flip_v = false
	else:
		sprite.animation = "attack_up"
		att_fx.animation = "att_fx_vertical"
		att_fx.flip_v = true

	sprite.play()
	att_fx.play()
	


func _on_animated_sprite_2d_animation_finished() -> void:
	isAttacking = false
	pass # Replace with function body.


func _on_atack_effect_animation_finished() -> void:
	player.att_fx_sprite.visible = false
	player.att_fx_sprite.stop()
	pass # Replace with function body.
