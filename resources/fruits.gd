@export var types : Array = [
	{fruit_name="cerise",scale_factor=.060,score_value=10,sprite_texture_path="res://assets/fruits/cerise.png"},
	{fruit_name="fraise",scale_factor=.120,score_value=25,sprite_texture_path="res://assets/fruits/fraise.png"},
	{fruit_name="raisin",scale_factor=.180,score_value=50,sprite_texture_path="res://assets/fruits/raisin.png"},
	{fruit_name="dekopon",scale_factor=.250,score_value=75,sprite_texture_path="res://assets/fruits/dekopon.png"},
	{fruit_name="orange",scale_factor=.320,score_value=100,sprite_texture_path="res://assets/fruits/orange.png"},
	{fruit_name="pomme",scale_factor=.390,score_value=110,sprite_texture_path="res://assets/fruits/pomme.png"},
	{fruit_name="poire",scale_factor=.500,score_value=125,sprite_texture_path="res://assets/fruits/poire.png"},
	{fruit_name="peche",scale_factor=.610,score_value=150,sprite_texture_path="res://assets/fruits/peche.png"},
	{fruit_name="anana",scale_factor=.750,score_value=200,sprite_texture_path="res://assets/fruits/anana.png"},
	{fruit_name="melon",scale_factor=1.00,score_value=300,sprite_texture_path="res://assets/fruits/melon.png"},
	{fruit_name="pasteque",scale_factor=1.25,score_value=500,sprite_texture_path="res://assets/fruits/pasteque.png"}
]


func next_type(fruit_name : String):
	var type = null
	var current_type = types.filter(func (t): return t.fruit_name == fruit_name)
	if current_type.size() == 1:
		var index = types.find(current_type[0])
		if index != -1 && index < types.size() - 1:
			type = types[index + 1]
	return type
