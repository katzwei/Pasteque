extends Node


@export var fruitPackedScene : PackedScene
@export var fruitsResource : Resource


var fruit_types : Array = []
var fruit_max_value : int = 0
var fruitTypeSlider : HSlider = null
var fruitContinuousCheck : CheckButton = null
var fruitScaleSlider : HSlider = null
var fruitScaleCheck : CheckButton = null
var useMouseCheck : CheckButton = null
var nextFruit : BoxContainer = null
var nextFruitCheck : CheckButton = null
var player : CharacterBody2D = null

#var fruits : Array = []
var next_fruits : Array = []
var next_fruit : Dictionary = {}


var _main_action_pressed = false


func _ready():
	fruit_types = fruitsResource.types
	fruit_max_value = fruit_types.size() - 1
	fruitTypeSlider = $FruitTypeSlider
	fruitContinuousCheck = $FruitContinuousCheck
	fruitTypeSlider.max_value = fruit_max_value
	fruitScaleSlider = $FruitScaleSlider
	fruitScaleCheck = $FruitScaleCheck
	useMouseCheck = $UseMouseCheck
	nextFruit = $NextFruit
	nextFruitCheck = $NextFruitCheck
	next_fruits = fruit_types.slice(0, 5)
	player = $Player
	ready_next_fruit()


func ready_next_fruit():
	next_fruit = next_fruits[randi_range(0,4)]
	nextFruit.set_next_fruit(next_fruit.sprite_texture_path)


func fruit_from_next_fruit():
	var fruit = next_fruit
	ready_next_fruit()
	return fruit


func fruit_from_slider():
	return fruit_types[fruitTypeSlider.value];


func get_fruit_spawn_position() -> Vector2:
	var position : Vector2 = Vector2.ZERO
	if useMouseCheck.button_pressed:
		position = get_viewport().get_mouse_position()
	else:
		position = player.position + Vector2.DOWN * 100
	return position


func spawn_fruit(fruit : Dictionary):
	var fruitScene = fruitPackedScene.instantiate()
	fruitScene.setup(fruit.fruit_name,fruit.scale_factor,fruit.score_value,fruit.sprite_texture_path)
	fruitScene.position = get_fruit_spawn_position()
	#fruits.append(fruitScene)
	add_child(fruitScene)


func _process(delta):
	if fruitContinuousCheck.button_pressed && _main_action_pressed:
		var fruit = fruit_from_next_fruit() if nextFruitCheck.button_pressed else fruit_from_slider()
		spawn_fruit(fruit)


func _unhandled_input(event):
	if event.is_action_pressed("main_action"):
		_main_action_pressed = true
	if event.is_action_released("main_action") && fruitContinuousCheck.button_pressed:
		_main_action_pressed = false
	if event.is_action_released ("main_action") && !fruitContinuousCheck.button_pressed:
		_main_action_pressed = false
		var fruit = fruit_from_next_fruit() if nextFruitCheck.button_pressed else fruit_from_slider()
		spawn_fruit(fruit)


func _on_fruit_clear_button_pressed():
	get_tree().call_group("fruit", "queue_free")



func _on_fruit_scale_slider_drag_ended(value_changed):
	if value_changed && fruitScaleCheck.button_pressed:
		for fruit in get_tree().get_nodes_in_group("fruit"):
			#var test = fruit.get_tree()
			#print(fruit)
			#fruit.print_tree()
			fruit.get_node("FruitCollision").scale = Vector2.ONE * fruitScaleSlider.value
