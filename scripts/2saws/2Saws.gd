extends Node2D

@onready var path_follow : PathFollow2D = $Path2D/PathFollow2D
@export var speed = 200
@onready var path_follow2 : PathFollow2D = $Path2D2/PathFollow2D

@onready var animation_sprite =  $Path2D/PathFollow2D/AnimatedSprite2D
@onready var animation_sprite2 = $Path2D2/PathFollow2D/AnimatedSprite2D

func _ready() -> void:
	animation_sprite.play("on")
	animation_sprite2.play("on")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow.progress += speed * delta
	path_follow2.progress += speed * delta
	
