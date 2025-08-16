extends CharacterBody2D

@export var speed = 35
@export var limit = 0.5
@export var endPoint: Marker2D

@onready var animations = $AnimationPlayer

var startPosition
var endPosition

func _ready() -> void:
	startPosition = position
	endPosition = endPoint.global_position
	
func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
	
func updateVelocity():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
		
	velocity = moveDirection.normalized()*speed
	
func updateAnimation():
	if velocity.length() == 0 and animations.is_playing():
		animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		
		animations.play("move" + direction)
		
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

func _physics_process(delta: float) -> void:
	updateVelocity()
	move_and_slide()
	handleCollision()
	updateAnimation()
