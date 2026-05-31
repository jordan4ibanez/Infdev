import luanti_types.Core;

class Vec3 {
	public var x: Float;
	public var y: Float;
	public var z: Float;

	public function new() {
		trace("I am a new vec3");
		x = Math.random();
		y = Math.random();
		z = Math.random();
	}
}

abstract class Entity {
	var pos: Vec3 = new Vec3();

	public function new(staticData: String, dtimeS: Float) {
		// this.pos = new Vec3();
		trace("good day, I am an entity", this.pos);
		// Lua.print("[" + staticData + "]", dtimeS);
	}
}

class Main {
	public static function main() {
		Core.registerEntity("haxe_luanti:test", {});

		Core.registerOnJoinPlayer(() -> {
			Core.requestShutdown();
		});
	};
}
