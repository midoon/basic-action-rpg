class_name Player extends CharacterBody2D

@onready var att_fx_sprite: AnimatedSprite2D = $AnimatedSprite2D/Atack_Effect
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

@export var SPEED := 100.0

var direction = Vector2.ZERO
var last_direction = Vector2.DOWN

func _ready() -> void:
	att_fx_sprite.visible = false
	state_machine.Initialize(self)
	
