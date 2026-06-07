package vector;

/**
 * This class technically doesn't exist.
 */
private abstract class EngineVector3 {
	var x: Float = 0;
	var y: Float = 0;
	var z: Float = 0;
}

class Vec3 extends EngineVector3 {
	public function new(?x: Float, ?y: Float, ?z: Float) {
		this.x = x ?? 0;
		this.y = y ?? 0;
		this.z = z ?? 0;
	}

	public function doThing() {
		trace(x, y, z);
	}
}
