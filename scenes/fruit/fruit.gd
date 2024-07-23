extends RigidBody2D


@export var fruitsResource : Resource


signal growth(value)


var _fruit_name : String = ""
var _scale_factor = 1.0
var _score_value : int = 0
var _sprite_texture_path : String = ""
var _next_fruit = null
var _fruit_vector = Vector2.ONE
#var _growth = false
var _shockwave_scale = 1.25
var _shockwave_vector = Vector2.ONE


func setup(fruit_name : String,
	scale_factor : float,
	score_value : int,
	sprite_texture_path : String):
		_fruit_name = fruit_name
		_scale_factor = scale_factor
		_score_value = score_value
		_sprite_texture_path = sprite_texture_path


func transform():
	add_to_group(_fruit_name)
	_fruit_vector = Vector2.ONE * _scale_factor
	$FruitSprite.scale = _fruit_vector
	$FruitCollision.scale = _fruit_vector
	$FruitHitArea/FruitHitCollision.scale = _fruit_vector
	_shockwave_vector = _fruit_vector * _shockwave_scale
	_next_fruit = fruitsResource.next_type(_fruit_name)
	if _sprite_texture_path != null && ResourceLoader.exists(_sprite_texture_path):
		$FruitSprite.texture = load(_sprite_texture_path)


func shockwave(growing : bool):
	match growing:
		true:
			$FruitShockwaveTimer.start()
			$FruitCollision.scale *= _shockwave_scale
		false:
			$FruitCollision.scale = _fruit_vector
		#_:
			#$FruitHitArea/FruitHitCollision.set_deferred("disabled", growing)
	#if (growing):
		#_growth = growing
		#$FruitHitArea/FruitHitCollision.set_deferred("disabled", growing)
		#$FruitCollision.set_deferred("disabled", growing)
	#else:
		#_growth = growing
		#$FruitHitArea/FruitHitCollision.set_deferred("disabled", growing)
		#$FruitCollision.set_deferred("disabled", growing)


func grow_to_next_fruit():
	if _next_fruit != null:
		remove_from_group(_fruit_name)
		growth.emit(_score_value)
		setup(_next_fruit.fruit_name,
			_next_fruit.scale_factor,
			_next_fruit.score_value,
			_next_fruit.sprite_texture_path)
		transform()
		shockwave(true)
		#if !_growth:
			#remove_from_group(_fruit_name)
			#setup(_next_fruit.fruit_name,
				#_next_fruit.scale_factor,
				#_next_fruit.score_value,
				#_next_fruit.sprite_texture_path)
			#transform()
			#shockwave(true)
	else:
		queue_free()


func _ready():
	transform()


#func _process(delta):
	#if _growth && $FruitCollision.scale < _shockwave_vector:
		#$FruitCollision.scale += Vector2.ONE * _shockwave_scale * delta
	#else:
		#$FruitCollision.scale = _fruit_vector
		#shockwave(false)
	#if _growth && _fruit_vector < _shockwave_vector:
		#_fruit_vector *= 1.01
		#$FruitCollision.scale = _fruit_vector
	#else:
		#shockwave(false)


func _on_fruit_hit_area_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group(_fruit_name):
		body.queue_free()
		grow_to_next_fruit()

