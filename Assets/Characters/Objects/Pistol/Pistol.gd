extends StaticBody2D

export( int ) var damage : int = 10 # hit points
export( float ) var reload_time : float = 0.6 # seconds

onready var reload_timer : Timer = $ReloadTimer
onready var hit_check : RayCast2D = $HitCheck

func _ready() -> void:
	
	# check for a parent
	get_node( "/root/Game/Player" ).connect( "use_weapon", self, "shoot" )


func shoot() -> void:
	
	if ( reload_timer.time_left == 0 ) and hit_check.is_colliding():
		
		hit_check.get_collider().character.update_health( -damage )
		reload_timer.start( reload_time )
