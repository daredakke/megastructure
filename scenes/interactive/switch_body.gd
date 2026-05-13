class_name SwitchBody
extends MaterialBody


func activate() -> void:
	EventsBus.activate_lift.emit(get_parent().assigned_lift.name)
