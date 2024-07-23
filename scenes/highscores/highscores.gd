extends CanvasGroup


class_name HighscoresHUD


var score_nodes : Array[Label] = []


func _ready():
	score_nodes = [
		$VBoxContainer/CenterContainer/Score1,
		$VBoxContainer/CenterContainer2/Score2,
		$VBoxContainer/CenterContainer3/Score3
	]

func set_scores(scores : Array):
	if scores.size() > 0:
		for i in scores.size():
			score_nodes[i].text = str(scores[i])
			score_nodes[i].visible = true


