extends CharacterBody2D


class_name Player


const SPEED = 300.0


var fruit = null


func _ready():
	fruit = $Fruit
	fruit.visible = false


func _process(delta):
	velocity = Vector2.ZERO
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED
	move_and_collide(velocity * delta)


func drop_fruit():
	fruit.visible = false


func set_fruit(texture_path : String, scale_factor : float):
	if texture_path != null && ResourceLoader.exists(texture_path):
		fruit.texture = load(texture_path)
		fruit.scale = Vector2.ONE * scale_factor
		fruit.visible = true


func get_fruit_start_position():
	return $FruitPosition.position

