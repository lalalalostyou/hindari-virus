extends Node

@export var mob_scene = preload("res://mob.tscn")
var score

func game_over() -> void:
	$Music.stop() 
	$DeathSound.play()
	$HUD.show_game_over()
	$ScoreTimer.stop()

func new_game() -> void:
	score = 0
	$Player.get_node("CollisionShape2D").set_deferred("disabled", false)
	$StartTimer.start()
	$Player.position = $StartPosition.position
	$Player.show()
	$HUD.update_score(score)
	$HUD.show_message("Persiapan!")
	get_tree().call_group("mobs","queue_free")
	$Music.play()


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLoc
	mob_spawn_location.progress_ratio = randf()
	
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
	

func  _ready() -> void:
	pass
	#new_game()
