extends Node2D

func _on_AnimationPlayer_animation_finished(anim_name):
	$Sprite.visible = false
	$Area2D/CollisionShape2D.queue_free()
	pass


func _on_AudioStreamPlayer2D_finished():
	queue_free()
	pass
