extends Area2D

var next_scene_validator := false

func _process(_delta):
	skip()

func skip() -> void:
	
	if next_scene_validator:
		next_scene_validator = false
		get_tree().change_scene_to_file("res://scenes/"+self.name.to_lower()+".tscn")

func _on_area_entered(area):
	if area.name == "Hitbox":
		next_scene_validator = true
