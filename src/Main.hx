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

	public function new(staticData: String, dtimeS: Float) {
		trace("good day, I am an entity", this.pos);
	}

	public function on_step() {
		trace("stepping");
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
