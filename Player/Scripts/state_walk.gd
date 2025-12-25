class_name StateWalk
extends State

@onready var idle_state: StateIdle = $"../Idle"
@onready var attack: StateAttack = $"../Attack"

func Enter() -> void:
	play_walk_animation()

func Physics(_delta: float) -> State:
	player.direction = get_input()

	if player.direction == Vector2.ZERO:
		return idle_state

	player.last_direction = player.direction
	player.velocity = player.direction.normalized() * player.SPEED
	player.move_and_slide()

	play_walk_animation()
	return null

func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null

func get_input() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

func play_walk_animation():
	var dir = player.direction
	var sprite = player.sprite

	if abs(dir.x) > abs(dir.y):
		sprite.animation = "walk_side"
		sprite.flip_h = dir.x < 0
	elif dir.y > 0:
		sprite.animation = "walk_down"
	else:
		sprite.animation = "walk_up"

	sprite.play()
