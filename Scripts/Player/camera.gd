extends Camera2D

@export var direction_speed: float = 600.0
@export var zoom_speed: float = 0.1

func _process(delta: float) -> void:
	var direction = Vector2.ZERO

	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1

	if direction != Vector2.ZERO:
		position += direction.normalized() * direction_speed * delta

	if Input.is_action_just_released("scroll up") and zoom < Vector2(4, 4):
		zoom += Vector2(zoom_speed, zoom_speed)
	if Input.is_action_just_released("scroll down") and zoom > Vector2(1, 1):
		zoom -= Vector2(zoom_speed, zoom_speed)
