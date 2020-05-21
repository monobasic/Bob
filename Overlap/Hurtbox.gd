extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

var invincible = false setget set_invincible

onready var timer = $Timer

signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = value # Setter is not calling itself
	if invincible:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func start_invincibility(duration):
	timer.start(duration)
	self.invincible = true

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position


func _on_Timer_timeout():
	self.invincible = false # Setter gets called only with self..


func _on_Hurtbox_invincibility_started():
	set_deferred("monitorable", false) 
	# set_deferred -> do something at the end of the game loop 
	# (monitorable can't be set during process physics')


func _on_Hurtbox_invincibility_ended():
	monitorable = true
