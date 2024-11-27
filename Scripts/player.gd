extends CharacterBody2D

var can_dash = true
var last_dir = -1.0
var anim = ''
var SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DASH = 10000.0
var is_sad = false
var coyote_timer : Timer 
var coyote_jump_available := true
const COYOTE_TIME = 0.08
@onready var root = get_node("/root/Main")


func _ready() -> void:
	coyote_timer = Timer.new()
	coyote_timer.wait_time = COYOTE_TIME
	coyote_timer.one_shot = true
	add_child(coyote_timer)
	coyote_timer.timeout.connect(coyote_timeout)


func _physics_process(delta: float) -> void:
	Global.past_positions.push_back(global_position)
	Global.current_anim.push_back(anim)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("up"):
		if coyote_jump_available:
			$Skok.play()
			velocity.y = JUMP_VELOCITY
			coyote_jump_available = false
			if !is_sad:
				%AnimationPlayer.play('jump_normal')
				anim = 'jump_normal'
			else:
				%AnimationPlayer.play('jump_sad')
				anim = 'jump_sad'
			
	if is_on_floor():
		coyote_jump_available = true
		coyote_timer.stop()
	else:
		if coyote_jump_available:
			if coyote_timer.is_stopped():
				coyote_timer.start()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction == 0:
		if !is_sad:
			%AnimationPlayer.play('idle_normal')
			anim = 'idle_normal'
		else:
			%AnimationPlayer.play('idle_sad')
			anim = 'idle_sad'
	if  direction != 0:
		if !is_sad:
			%AnimationPlayer.play('run_normal')
			anim = 'run_normal'
		else:
			%AnimationPlayer.play('run_sad')
			anim = 'run_sad'
	
		
	if direction > 0:
		$Player.flip_h = true
		last_dir = direction
	if direction < 0:
		$Player.flip_h = false
		last_dir = direction
	
	if last_dir > 0:
		Global.flip.push_back(true)
	if last_dir < 0:
		Global.flip.push_back(false)
	
	if is_on_floor() == false:
		if !is_sad:
			%AnimationPlayer.play("fall_normal")
			anim = 'fall_normal'
		else:
			%AnimationPlayer.play("fall_sad")
			anim = 'fall_sad'
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("dash"):
		if can_dash && direction !=0:
			$Skok.play()
			SPEED = 1000.0
			$Timer.start()
			$dash.start()
			can_dash = false
	move_and_slide()
	

func _on_timer_timeout() -> void:
	SPEED = 300.0


func _on_hurtbox_body_entered(body: Node2D) -> void:
	get_tree().paused = true
	$"../CanvasLayer". visible = true
	$Hurt.play()
	$Death.start()



func _on_sad_area_entered(area: Area2D) -> void:
	if area == $Hurtbox:
		return
	if not area.name == "Hurtbox":
		return
	is_sad = true

func _on_sad_area_exited(area: Area2D) -> void:
	if area == $Hurtbox:
		return
	if not area.name == "Hurtbox":
		return
	is_sad = false


func _on_death_timeout() -> void:
	get_tree().paused = false
	$"../CanvasLayer".visible = false
	root.load_level()
	


func _on_nuta_finished() -> void:
	$Nuta.play()


func _on_dash_timeout() -> void:
	can_dash = true
		


func _on_crush_box_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		return
	$Player.hide()
	$Explosion.emitting = true
	$Death.wait_time = 1
	get_tree().paused = true
	#$"../CanvasLayer". visible = true
	$Hurt.play()
	$Death.start()


func coyote_timeout() -> void:
	coyote_jump_available = false
