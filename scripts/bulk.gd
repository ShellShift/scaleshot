extends Enemy

var size: int

func _on_head_area_entered(body):
	if size == -1:
		super._on_head_area_entered(body)
	else: super._on_body_area_entered(body)

func _on_scaled(decrease):
	super._on_scaled(decrease)
	size = -1 if decrease else 1
