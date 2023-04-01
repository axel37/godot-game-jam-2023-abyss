extends Area2D

signal in_hotzone(hot_zone: HotZone, delta: float)

func _physics_process(delta):
	for area in get_overlapping_areas():
		if area is HotZone:
			in_hotzone.emit(area, delta)
