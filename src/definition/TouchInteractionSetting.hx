package definition;

enum abstract TouchInteractionMode(String) to String {
	var longDigShortPlace = "long_dig_short_place";
	var shortDigLongPlace = "short_dig_long_place";
	var user;
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
