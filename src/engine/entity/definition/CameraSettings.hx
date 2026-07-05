package src.engine.entity.definition;

enum abstract CameraMode(String) to String {
	var CameraModeAny = "any";
	var CameraModeFirst = "first";
	var CameraModeThird = "third";
	var CameraModeThirdFront = "third_front";
}

class CameraSettings.hx {
	public var mode: CameraMode;

	public function new(cameraMode: CameraMode) {
		this.mode = cameraMode;
	}
}
