extends Area2D
@export var speed = 200;
var screen_size;
signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position.x = screen_size.x / 2;
	position.y = screen_size.y / 2;
	hide()
	
func start(pos: Vector2):
	position = pos
	show()
	$CollisionShape2D.set_deferred("disabled", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1;
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1;
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1;
	if Input.is_action_pressed("move_down"):
		velocity.y += 1;
		
	if velocity.length() > 0:
		velocity = speed * velocity.normalized();
		get_node("AnimatedSprite2D").play()
	else:
		get_node("AnimatedSprite2D").stop()
	
	position += velocity * delta;
	position = position.clamp(Vector2.ZERO, screen_size)	
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk_default"
		$AnimatedSprite2D.flip_v = false
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true;
	else:
		$AnimatedSprite2D.flip_h = false;

func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true) # Replace with function body.
