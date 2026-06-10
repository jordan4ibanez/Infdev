package vector;

import luantitypes.LogLevel;
import luantitypes.Core;

class Vec3 extends EngineVector3 {
	public function new(?x: Float, ?y: Float, ?z: Float) {
		this.x = x ?? 0;
		this.y = y ?? 0;
		this.z = z ?? 0;
	}

	/**
	 * Don't use this in your mods. This will destroy the GC as well.
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

	/**
	 * Don't use this in your mods. This requires an input haxe Vec3 to transfer the fields into.
	 * @param engineVec3 A plain vec3 from the engine.
	 * @param haxeVec An an advanced Vec3 from haxe.
	 */
	public static function fromEngineFast(engineVec3: Dynamic, haxeVec: Vec3) {
		if (engineVec3 != null) {
			// This should cause an error if it's a 2D vector or the wrong type.
			// Blindly accept that it's a vec3 from luanti.

			haxeVec.x = engineVec3.x;
			haxeVec.y = engineVec3.y;
			haxeVec.z = engineVec3.z;
		} else {
			// Make a bunch of noise if input was null.
			Core.log(LogLevel.error, "Received null engine vec.");
		}
	}

	public function doThing() {
		trace(x, y, z);
	}
}
