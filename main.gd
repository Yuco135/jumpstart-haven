extends Node2D

var score = 0
@onready var score_label = %CoinCount

func _ready():
	for child in get_children():
		if child.has_signal("coin_collected"):
			child.coin_collected.connect(_on_coin_collected)

func _on_coin_collected(body):
	if body.name == "Player":
		score += 1
		score_label.text = "Coin Count: %d" % score
		print("Coin Collected")

func do():
	var timer = Timer.new()
	timer.wait_time = 1.7  # seconds between spawns
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	randomize()
	var coin = preload("res://coin.tscn").instantiate()
	coin.position.y = -372  # above screen
	coin.position.x = randf_range(-930.0, 917.0)  # random horizontal position
	add_child(coin)
	coin.body_entered.connect(_on_coin_collected)
