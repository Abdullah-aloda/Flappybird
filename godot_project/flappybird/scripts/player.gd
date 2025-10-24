class_name Player extends CharacterBody2D #Class of player 

#########################################################################################################

signal laser_shot(laser_scene, location) # Signal sent when player fires a laser
signal killed #Signal sent when player dies

############################################################################################################

@export var speed = 300 # We make speed changable 

@onready var muzzle = $Muzzle # Muzzle which is right infront of our spaceship so laser comes out from there

############################################################################################################

var laser_scene = preload("res://scenes/laser.tscn") #Laser scene preloaded for fast instancing

var shoot_cd := false #Effective Simple cooldown flag to prevent continuous firing

#############################################################################################################
func _process(delta):  #This will run every frame to catch inputs
	if Input.is_action_pressed("shoot"): # If "space is the action" is just pressed (held)
		if !shoot_cd:
			shoot_cd = true # Shooting cooldown so true (we have cool down)
			shoot() #And we shoot
			await get_tree().create_timer(.5).timeout #I created a cool down so no spam fire shooting or it would be too easy
			shoot_cd = false #Allow shooting
 

func _physics_process(delta): #This is for the physics very basic but it works
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")) #So left right up down are all with W A S D
	velocity = direction * speed # Velocity is speed with direcition lol
	move_and_slide() #I had to learn the hard way this is NEEDED 
	position.x = clamp(position.x, -230, 230) #I created a border so the sprite can't go beyond visible borders
	position.y = clamp(position.y, -750, 100) #Same thing but for Y axis


func shoot(): #The shoot function
	laser_shot.emit(laser_scene, muzzle.global_position) # Tell whoever listens to create a laser at the muzzle


func die(): #Function EVEN THOUGH THIS CODE SEEMS SIMPLE I ALSO SPENTS COUNTLESS HOURS TRYING TO DEBUG!!! >:(
	killed.emit() #Notify that player has died
	await get_tree().create_timer(0.01) #Very tiny wait to let the signals process
	queue_free() #This removes player node for scene
