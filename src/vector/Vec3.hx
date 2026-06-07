package vector;

import luanti_types.LogLevel;
import luanti_types.Core;

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

	/**
	 * Don't use this in your mods.
	 * @param engineVec3 A plain vec3 from the engine.
	 * @return Vec3 An advanced Vec3 from haxe.
	 */
	public static function fromEngine(engineVec3: Dynamic): Vec3 {
		var output = new Vec3();

		if (engineVec3 != null) {
			// This should cause an error if it's a 2D vector or the wrong type.
			// Blindly accept that it's a vec3 from luanti.

			output.x = engineVec3.x;
			output.y = engineVec3.y;
			output.z = engineVec3.z;
		} else {
			// Make a bunch of noise if input was null.
			Core.log(LogLevel.error, "Received null engine vec.");
		}

		return output;
	}

	public function doThing() {
		trace(x, y, z);
	}
}
