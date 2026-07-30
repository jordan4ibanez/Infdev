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

	public function toHex(): String {
		var rHex = StringTools.hex(this.r & 0xFF, 2);
		var gHex = StringTools.hex(this.g & 0xFF, 2);
		var bHex = StringTools.hex(this.b & 0xFF, 2);
		var aHex = StringTools.hex(this.a & 0xFF, 2);

		return '#$rHex$gHex$bHex$aHex';
	}
}
