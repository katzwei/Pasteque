extends Node


@export var fruitPackedScene : PackedScene
@export var fruitsResource : Resource


var fruit_types : Array = []
var fruit_max_value : int = 0
var nextFruit : NextFruitHUD = null
var next_fruits : Array = []
var next_fruit = null
var player : Player = null
var basket : Basket = null
var scoreHUD : ScoreHUD = null
var highscoresHUD : HighscoresHUD = null
var score = 0


func _ready():
	fruit_types = fruitsResource.types
	fruit_max_value = fruit_types.size() - 1
	nextFruit = $NextFruit
	next_fruits = fruit_types.slice(0, 5)
	player = $Player
	basket = $Basket
	scoreHUD = $Score
	highscoresHUD = $Highscores
	load_score()
	ready_next_fruit()


func ready_next_fruit():
	next_fruit = next_fruits[randi_range(0,4)]
	player.set_fruit(next_fruit.sprite_texture_path, next_fruit.scale_factor)
	nextFruit.set_next_fruit(next_fruit.sprite_texture_path)


func fruit_from_next_fruit():
	var fruit = next_fruit
	ready_next_fruit()
	return fruit


func increase_score(_event, value : int):
	score += value
	scoreHUD.set_score(score)


func spawn_fruit(fruit : Dictionary):
	var fruitScene = fruitPackedScene.instantiate()
	fruitScene.growth.connect(increase_score.bind(fruit.score_value))
	fruitScene.setup(fruit.fruit_name,fruit.scale_factor,fruit.score_value,fruit.sprite_texture_path)
	fruitScene.position = player.position + Vector2.DOWN * 50
	add_child(fruitScene)


func _unhandled_input(event):
	if event.is_action_pressed("main_action") && next_fruit != null:
		player.drop_fruit()
		spawn_fruit(next_fruit)
		next_fruit = null


func load_score():
	var file_access_mode = FileAccess.WRITE_READ
	if FileAccess.file_exists("user://highscores.txt"):
		file_access_mode = FileAccess.READ_WRITE
	var file = FileAccess.open("user://highscores.txt", file_access_mode)
	file.seek_end()
	file.store_string("%s\n" % score)
	var scores = Array(file.get_as_text().strip_edges().split("\n"))
	scores.sort_custom(func(a, b): return int(a) > int(b))
	highscoresHUD.set_scores(scores.slice(0, 3))


func clear_basket():
	get_tree().call_group("fruit", "queue_free")
	load_score()
	scoreHUD.set_score(0)



func _on_basket_danger_line_crossed():
	clear_basket()


func _on_basket_basket_filled():
		ready_next_fruit()

