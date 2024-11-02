extends Node2D


var INVENTORY_SIZE = 4


class InventorySlot:
	var empty = false
	var num = 0 #this is the number of the same item in that slot, up to 16 pers stack

	
	#Add item type here later

var slot : Array[InventorySlot] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slot.resize(INVENTORY_SIZE)
	for i in INVENTORY_SIZE:
		slot[i] = InventorySlot.new()

	# Setting info for watering can
	slot[0].empty = true
	slot[0].num = 1

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


# Returns the slot number of the next open slot, which doesn't contain any items
func nextOpen():
	for i in INVENTORY_SIZE:
		if slot[i].empty == true:
			return i+1
