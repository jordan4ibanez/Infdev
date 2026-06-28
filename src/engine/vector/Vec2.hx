package src.engine.vector;

import src.engine.Core;

class Vec2 extends EngineVector2 {
	public function new(?x: Float, ?y: Float) {
		this.x = x ?? 0;
		this.y = y ?? 0;
	}

	/**
	 * Don't use this in your mods. This will destroy the GC as well.
	 * @param engineVec2 A plain vec2 from the engine.
	 * @return Vec2 An advanced Vec2 from haxe.
	 */
	public static function fromEngine(engineVec2: Dynamic): Vec2 {
		var output = new Vec2();
		if (engineVec2 != null) {
			// This should cause an error if it's a 2D vector or the wrong type.
			// Blindly accept that it's a vec2 from luanti.
			output.x = engineVec2.x;
			output.y = engineVec2.y;
		} else {
			// Make a bunch of noise if input was null.
			Core.log(LogLevelError, "Received null engine vec2.");
		}
		return output;
	}

	/**
	 * Don't use this in your mods. This requires an input haxe Vec2 to transfer the fields into.
	 * @param engineVec2 A plain vec2 from the engine.
	 * @param haxeVec An an advanced Vec2 from haxe.
	 */
	public static function fromEngineFast(engineVec2: Dynamic, haxeVec: Vec2) {
		if (engineVec2 != null) {
			// This should cause an error if it's a 2D vector or the wrong type.
			// Blindly accept that it's a vec2 from luanti.

			haxeVec.x = engineVec2.x;
			haxeVec.y = engineVec2.y;
		} else {
			// Make a bunch of noise if input was null.
			Core.log(LogLevelError, "Received null engine vec2.");
		}
	}

	public function doThing() {
		trace(x, y);
	}
}
