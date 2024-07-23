extends CanvasGroup


class_name NextFruitHUD


var nextFruitSprite : TextureRect


func _ready():
	nextFruitSprite = $MarginContainer/CenterContainer/NextFruitSprite


func set_next_fruit(texture_path : String):
	if texture_path != null && ResourceLoader.exists(texture_path):
		nextFruitSprite.texture = load(texture_path)

