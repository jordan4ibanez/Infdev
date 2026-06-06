import entity.Mob;
import luanti_types.Core;

class Vec3 {
	public var x: Float;
	public var y: Float;
	public var z: Float;

	public function new() {
		// trace("I am a new vec3");
		x = Math.random();
		y = Math.random();
		z = Math.random();
	}
}

class Main {
	public static function main() {
		Core.registerEntity("haxe_luanti:test", Mob);

		Core.registerOnJoinPlayer(() -> {
			// Core.requestShutdown();
		});
	};
}
