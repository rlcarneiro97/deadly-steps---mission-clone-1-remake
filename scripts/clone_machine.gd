extends StaticBody2D

var cloneMachineDamage := 13.0

@onready var destroyAnim = $DestroyAnim
@onready var timer = $Timer
@onready var marker = $Marker2D
@onready var explosionEffect = $ExplosionEffect
var pre_enemy = preload("res://scenes/clone_type_0.tscn")

func instanceEnemy() -> void:
	var enemyInstance = pre_enemy.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	enemyInstance.global_position = marker.global_position
	get_parent().add_child(enemyInstance)
	
	if timer.wait_time == 0.1:
		timer.one_shot = false
		timer.wait_time = 4
		timer.start()
		
func applyDamage(bullet_damage):
	
	MusicController.playDamageCloneMachineFX()
	cloneMachineDamage -= bullet_damage
	
	if cloneMachineDamage <= 0:
		self.destroyObject()
	
func destroyObject():
	
	MusicController.playExplodeFX()
	self.collision_layer = 0
	destroyAnim.play("CloneMachineDestroy")
	await destroyAnim.animation_finished
	self.queue_free()

func _on_timer_timeout():
	self.instanceEnemy()
