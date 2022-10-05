extends Node2D

class_name Character


export( float ) var health : int = 100


func update_health( value : int ) -> void:
	
	health += value
	print( "Received ", value, " to health" )
