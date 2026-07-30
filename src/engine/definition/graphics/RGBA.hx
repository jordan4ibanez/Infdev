package src.engine.definition.graphics;

final class RGBA {
	var r: Int;
	var g: Int;
	var b: Int;
	var a: Int;

	public function new(r: Int, g: Int, b: Int, a: Int) {
		this.r = r;
		this.g = g;
		this.b = b;
		this.a = a;
	}

	// This is AI assisted.
	function hexify(input: Float): Float {
		return input < 0 ? 0 : (input > 255 ? 255 : input);
	}

	// This is AI assisted.
	public function toHex(): String {
		var hexR = hexify(r);
		var hexG = hexify(g);
		var hexB = hexify(b);
		var hexA = hexify(a);
		// Also haxe doesn't have a built in formatter or string.format for lua in this version??
		// That's why the AI was originally needed but this code could have been created without it if I knew that.
		return untyped __lua__('string.format("#%02X%02X%02X%02X", {0}, {1}, {2}, {3})', hexR, hexG, hexB, hexA);
	}
}
