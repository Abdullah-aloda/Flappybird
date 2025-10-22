class_name Player extends CharacterBody2D

signal laser_shot(laser_scene, location)

@export var speed = 300

@onready var muzzle = $Muzzle

var laser_scene = preload("res://scenes/laser.tscn")

var shoot_cd := false

func _process(delta):
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(.25).timeout
			shoot_cd = false

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("move_left",
"move_right"), Input.get_axis("move_up", "move_down"))
	print(direction)
	velocity = direction * speed
	move_and_slide()
	

func shoot():
	laser_shot.emit(laser_scene, muzzle.global_position)
	
func die():
	queue_free()
