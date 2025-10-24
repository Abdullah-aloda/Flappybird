extends Area2D # This automatically pops up when we make a script

###############################################################################################################################

@export var speed := 600.0 #I set laser speed to double of players
@export var damage = 1 #Laser does 1 damage (fast enenemy is 1hp while slow is 2hp) 

#################################################################################################################################

func _physics_process(delta): # Always needed for movement
	global_position.y += -speed * delta # Moves laser forwad(Up in godot in negative which is weird) and multiply by delta for single frame

func _on_visible_on_screen_notifier_2d_screen_exited(): #This is a node from the laser I just added it
	queue_free() #so if it leaves the scene it gets evaporated

func _on_area_entered(area): # I used this too from the nodes since I want to see if area touched another (enter)
	if area is Enemy: # If that area is the enemy
		area.take_damage(damage) # damage is taken which is 1
		queue_free() #Laser disappears into thin air (the queue_free makes the sprite free from the scene) 
