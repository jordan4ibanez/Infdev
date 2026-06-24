package src.engine.definition;

enum abstract TouchInteractionMode(String) to String {
	var TouchInteractionModeLongDigShortPlace = "long_dig_short_place";
	var TouchInteractionModeShortDigLongPlace = "short_dig_long_place";
	var TouchInteractionModeUser = "user";
}

final class TouchInteractionSetting {
	@:native("pointed_nothing")
	var pointedNothing: TouchInteractionMode;
	@:native("pointed_node")
	var pointedNode: TouchInteractionMode;
	@:native("pointed_object")
	var pointedObject: TouchInteractionMode;

	public function new(pointedNothing: TouchInteractionMode, pointedNode: TouchInteractionMode, pointedObject: TouchInteractionMode) {
		this.pointedNothing = pointedNothing;
		this.pointedNode = pointedNode;
		this.pointedObject = pointedObject;
	}
}
