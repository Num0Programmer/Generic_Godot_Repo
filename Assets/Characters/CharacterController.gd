extends KinematicBody2D

class_name CharacterController


export( float ) var run_accel : float = 200           # m/s/s
export( float ) var jump_accel : float = 600 * 16     # m/s/s
export( float ) var gravity : float = 300             # m/s/s
export( float ) var drag : float = 220                # m/s/s
export( float ) var terminal_speed : float = 100      # m/s


var velocity : Vector2 = Vector2.ZERO

var x_input : float = 0

var jumping : bool = false
var jump_cool_down : float = 0.2

onready var character : Character = $Character
onready var ground_check : RayCast2D = $GroundCheck
onready var sprite : Sprite = $Sprite


func _ready() -> void:
	pass


func _process( delta : float ) -> void:
	pass


func _physics_process( _delta : float ) -> void:
	pass


func _animate_sprite( direction : float ) -> void:
	pass


func _gravity( time_step : float ) -> void:
	
	if !ground_check.is_colliding() and !jumping:
		
		velocity.y = move_toward( velocity.y, velocity.y + gravity,
									gravity * time_step )


func _move( time_step : float ) -> void:
	pass
