import lua.Lua;
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



class Mob extends Entity {
	override function onActivate(staticData: String, dtimeS: Float) {
		super.onActivate(staticData, dtimeS);
	}

	override function onStep(delta: Float) {
		super.onStep(delta);
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
