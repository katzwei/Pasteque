extends Node2D


class_name Basket


var fruitsInBasket = []
var fruitsOverflowing = []


signal basket_overflow
signal basket_filled


func fruit_overflow():
	fruitsInBasket.clear()
	basket_overflow.emit()


func _on_overflow_area_area_entered(area):
	if area.get_parent().is_in_group("fruit"):
		var fruit_object_id = area.get_instance_id()
		fruitsOverflowing.append(fruit_object_id)
		if fruitsInBasket.has(fruit_object_id):
			fruit_overflow()


func _on_overflow_area_area_exited(area):
	if area.get_parent().is_in_group("fruit"):
		fruitsOverflowing.erase(area.get_instance_id())


func _on_fill_area_area_entered(area):
	if area.get_parent().is_in_group("fruit"):
		var fruit_object_id = area.get_instance_id()
		fruitsInBasket.append(fruit_object_id)
		await get_tree().create_timer(1.0).timeout
		basket_filled.emit()
		if fruitsOverflowing.has(fruit_object_id):
			fruit_overflow()

