import luanti_types.Macros;
import lua.Lua;
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

class Entity {
	var pos: Vec3 = new Vec3();
	var uuid: Int = 0;

	// This returns this.
	public function new() {}

	public function on_activate(staticData: String, dtimeS: Float) {
		Macros.entityPatch();
	}

	public function on_step() {
		Lua.print(this.uuid);
	}


}

class EntityRegistrationTesting {
	// This is the hijacked function.
	static public inline function registerEntity(name: String, clazz: Class<Entity>): Void {
		// Class components.
		var prototype = Reflect.field(clazz, "prototype");
		var rawLuantiPrototype: Dynamic = {}
		for (method in Reflect.fields(prototype)) {
			untyped rawLuantiPrototype[method] = Reflect.getProperty(prototype, method);
		}
		Core.register_entity(name, rawLuantiPrototype);
	}
}

class Mob extends Entity {
	var myCoolName = "fred";

	override function on_activate(staticData: String, dtimeS: Float) {
		super.on_activate(staticData, dtimeS);
		Macros.entityPatch();

		trace(this.myCoolName);
	}
}

class Main {
	public static function main() {
		EntityRegistrationTesting.registerEntity("haxe_luanti:test", Mob);

		Core.registerOnJoinPlayer(() -> {
			// Core.requestShutdown();
		});
	};
}
