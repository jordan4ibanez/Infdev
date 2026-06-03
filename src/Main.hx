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
		// Instance components.
		final instance = Type.createInstance(Macros.getCompileTimeClass(), []);
		for (field in Reflect.fields(instance)) {
			untyped this[field] = Reflect.field(instance, field);
		}
	}

	public function on_step() {
		Lua.print(this.uuid);
	}
}

class Main {
	public static function main() {
		var blah: Dynamic = {}
		blah.on_activate = Entity.new;
		untyped {
			blah.on_step = Entity.prototype.on_step;
		}

		Core.registerEntity("haxe_luanti:test", blah);

		Core.registerOnJoinPlayer(() -> {
			// Core.requestShutdown();
		});
	};
}
