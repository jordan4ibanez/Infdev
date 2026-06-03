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
		final instance = new Entity();

		for (field in Reflect.fields(instance)) {
			var val = Reflect.field(instance, field);
			untyped {
				this[field] = val;
			}
			Lua.print(field, val);
		}

		// Class components.
		var clazz = Reflect.field(Entity, "prototype");

		for (method in Reflect.fields(clazz)) {
			Lua.print(method);
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
