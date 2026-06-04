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

@:autoBuild(luanti_types.EntityDuctTape.build())
@:build(luanti_types.EntityDuctTape.build())
class Entity {
	// This returns this.
	public function new() {}

	@:native("on_activate")
	public function onActivate(staticData: String, dtimeS: Float) {
		// trace(this.uuid);
		Lua.print("hello world! from Entity");
	}

	@:native("on_step")
	public function onStep(delta: Float) {}

	final public function getGUID(): String {
		return untyped __lua__("self.object:get_guid()");
	};
}

class Mob extends Entity {
	override function onActivate(staticData: String, dtimeS: Float) {
		super.onActivate(staticData, dtimeS);
		Lua.print("hello world! from Mob");
	}

	override function onStep(delta: Float) {
		super.onStep(delta);
	}
}

// TODO: Move this thing back into the Core as an inline
class EntityRegistrationTesting {

}

// class Mob extends Entity {
// 	var myCoolName = "fred";
// 	override function on_activate(staticData: String, dtimeS: Float) {
// 		super.on_activate(staticData, dtimeS);
// 	}
// }

class Main {
	public static function main() {
		EntityRegistrationTesting.registerEntity("haxe_luanti:test", Mob);

		Core.registerOnJoinPlayer(() -> {
			// Core.requestShutdown();
		});
	};
}
