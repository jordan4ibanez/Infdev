package definition.images;

import haxe.extern.EitherType;
import lua.Table;

enum abstract WearBarBlend(String) to String {
	var constant;
	var linear;
}

final class WearBarColors {
	var blend: WearBarBlend;

	@:native("color_stops")
	var colorStops: Table<Float, EitherType<String, RGBA>>;

	public function new(blend: WearBarBlend) {
		this.blend = blend;
	}

	public function addColorStop(time: Float, colorData: EitherType<String, RGBA>): WearBarColors {
		if (this.colorStops == null) {
			this.colorStops = Table.create();
		}
		untyped this.colorStops[time] = colorData;
		return this;
	}
}

class Blah {
	static function __init__() {
		var i = new WearBarColors(WearBarBlend.constant)
			.addColorStop(0.0, "red")
			.addColorStop(0.2, "redsaf")
			.addColorStop(0.4, "blue")
			.addColorStop(0.5, "fred")
			.addColorStop(0.8, "wat")
			.addColorStop(1.0, new RGBA(255, 255, 255, 255));

		untyped __lua__("print(dump(i))");
	}
}
