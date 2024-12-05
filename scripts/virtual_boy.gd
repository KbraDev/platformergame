extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0

@onready var animated_sprite = $animatedSprite2D

func _ready() -> void:
	animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_movement()
	handle_animation()
	move_and_slide()

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func handle_movement() -> void:
	# Realizar el salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movimiento horizontal
	var direction = 0
	if Input.is_action_pressed("move_left"):
		direction -= 1
	if Input.is_action_pressed("move_right"):
		direction += 1

	velocity.x = direction * SPEED if direction != 0 else move_toward(velocity.x, 0, SPEED)

	# Voltear el sprite según la dirección
	if direction != 0:
		animated_sprite.flip_h = direction < 0

	# Lógica para wall jump (opcional, puedes eliminar si no lo necesitas)
	if is_on_wall() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
		velocity.x = 200 if Input.is_action_pressed("move_right") else -200

func handle_animation() -> void:
	if not is_on_floor():
		animated_sprite.play("jumping")
	elif velocity.x != 0:
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")
		
	if is_on_wall() :
		animated_sprite.play("wallJump")
