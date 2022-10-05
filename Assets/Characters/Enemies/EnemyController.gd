extends CharacterController

class_name EnemyController


export( float ) var path_check_dist : float = 50

var move_direction : Vector2 = Vector2.ZERO

onready var path_check : RayCast2D = $PathCheck
onready var player : CharacterController = get_node( "/root/Game/Player" )


func _ready() -> void:
	pass


func _physics_process( _delta : float ) -> void:
	
	# get direction to player
	move_direction = direction_to_player()
	
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
				( -1.0 < move_direction.y and move_direction.y < -0.2 ) and
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
