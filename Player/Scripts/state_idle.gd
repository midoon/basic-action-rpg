class_name StateIdle
extends State

@onready var walk_state: StateWalk = $"../Walk"
@onready var attack: StateAttack = $"../Attack"

func Enter() -> void:
	
	play_idle_animation()

func Physics(_delta: float) -> State:
	player.direction = get_input()
	player.velocity = Vector2.ZERO

	if player.direction != Vector2.ZERO:
		player.last_direction = player.direction
		return walk_state

	return null

func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null

func get_input() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"),
	)

func play_idle_animation():
	var dir = player.last_direction
	var sprite = player.sprite

	if abs(dir.x) > abs(dir.y):
		sprite.animation = "idle_side"
		sprite.flip_h = dir.x < 0
	elif dir.y > 0:
		sprite.animation = "idle_down"
	else:
		sprite.animation = "idle_up"

	sprite.play()
