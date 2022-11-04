extends CharacterController

class_name EnemyController


# defines a percentage how far above the player can be which will influence if the
# enemy determines it needs to move left or right to get up to the player
# TODO: this will also be used to determine which direction to head when the
# player is below the enemy character
export( float ) var percent_above : float = -0.5
export( float ) var path_check_dist : float = 50

var move_direction : Vector2 = Vector2.ZERO

onready var path_check : RayCast2D = $PathCheck
onready var player : CharacterController = get_node( "/root/Game/Player" )


func _ready() -> void:
	pass


func _physics_process( _delta : float ) -> void:
	
	# get direction to player
	move_direction = direction_to_player()
	move_direction = translate_move_direction( move_direction )
	
	print( move_direction )
	
	# update path checking
	path_check.set_cast_to( move_direction * path_check_dist )
	
	# move the enemy in the direction of the player
	_move( _delta )


func _animate_sprite( direction : float ) -> void:
	
	if direction < 0:
		
		sprite.scale = Vector2( -1, 1 )
		
	elif direction > 0:
		
		sprite.scale = Vector2( 1, 1 )


func direction_to_player() -> Vector2:
	
	return global_position.direction_to( player.global_position )


func _move( time_step : float ) -> void:
	
	jumping = ( path_check.is_colliding() and
				( -0.6 <= move_direction.y and move_direction.y <= -0.3 ) and
				ground_check.is_colliding() )
	
	if move_direction.x != 0:
		
		velocity.x = move_toward( velocity.x, move_direction.x * terminal_speed,
									run_accel * time_step )
		
	else:
		
		velocity.x = move_toward( velocity.x, 0, drag * time_step )
	
	if jumping:
		velocity.y = -jump_accel * time_step
	
	# applying gravity
	_gravity( time_step )
	
	# animate sprite
	
	velocity = move_and_slide( velocity )


func translate_move_direction( input_dir : Vector2 ) -> Vector2:
	
	var change_input_dir : bool = false
	
	if input_dir.y <= -0.5:
		input_dir.y = -0.3
		
		change_input_dir = true
		
	elif input_dir.y >= 0.5:
		input_dir.y = 0.3
		
		change_input_dir = true
	
	if change_input_dir and path_check.get_cast_to().x > 0:
		
		input_dir.x = 1
		
	elif change_input_dir:
		
		input_dir.x = -1
	
	return input_dir
