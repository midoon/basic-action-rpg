class_name State extends Node

# stores a reference to the player that this State belongs to
static var player: Player


# what happens when the player enters this state?
func Enter() -> void:
	pass

# what happens when the player exit this state
func Exit() -> void:
	pass

#What happens during the _process update in this State?
func Process(_delta: float) -> State:
	return null

# what happens during the _physics_process update in this State?
func Physics(_delta : float) ->State:
	return null

# What happens with input  evenets in this State?
func HandleInput(_event: InputEvent) -> State:
	return null
