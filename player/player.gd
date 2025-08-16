extends CharacterBody2D

@export var speed: int = 50
@onready var animations = $AnimationPlayer

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	var currentSpeed = speed
	if Input.is_key_pressed(KEY_SHIFT):
		currentSpeed += 30
	
	velocity = moveDirection.normalized() * currentSpeed

func updateAnimation():
	if velocity.length() == 0 and animations.is_playing():
		animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		
		animations.play("move" + direction)
	# print(velocity) # for debugging

func _physics_process(delta: float) -> void:
	handleInput()
	move_and_slide()
	updateAnimation()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "hitbox":
		print_debug(area.get_parent().name)
