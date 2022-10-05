extends CharacterController

class_name PlayerController


onready var weapon_hold : Node2D = $WeaponHold


# signals
signal use_weapon


func _physics_process( _delta : float ) -> void:
	
	use_weapon()
	_move( _delta )


func _animate_sprite( direction : float ) -> void:
	
	if direction < 0:
		
		sprite.scale = Vector2( -1, 1 )
		weapon_hold.scale = Vector2( -1, 1 )
		
	elif direction > 0:
		
		sprite.scale = Vector2( 1, 1 )
		weapon_hold.scale = Vector2( 1, 1 )


func _move( time_step : float ) -> void:
	
	x_input = Input.get_axis( "move_left", "move_right" )
	jumping = ( Input.is_action_pressed( "jump" ) and
				ground_check.is_colliding() )
	
	# changing horizontal velocity of player object
	if x_input != 0:
		
		velocity.x = move_toward( velocity.x, x_input * terminal_speed,
									run_accel * time_step )
		
	else:
		
		velocity.x = move_toward( velocity.x, 0, drag * time_step )
	
	# chaning vertical velocity of player object
	if jumping:
		velocity.y = -jump_accel * time_step
	
	# applying gravity
	_gravity( time_step )
	
	# animating player
	_animate_sprite( x_input )
	
	# move the player
	velocity = move_and_slide( velocity )


func use_weapon() -> void:
	
	if Input.is_action_pressed( "use_weapon" ):
		emit_signal( "use_weapon" )
