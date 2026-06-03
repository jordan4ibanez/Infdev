package luanti_types;

import haxe.Rest;
import Reflect;
// These are public imports. :)
import luanti_types.LogLevel;

@:native("core")
extern class Core {
	static function log(level: LogLevel, text: String): Void;

	// fixme: this is incorrect.
	// This is the real function.
	private static extern function register_entity(name: String, prototype: Dynamic): Void;

	// This is the hijacked function.
	static public inline function registerEntity(name: String, clazz: Dynamic): Void {
		// Class components.
		var prototype = Reflect.field(clazz, "prototype");
		var rawLuantiPrototype: Dynamic = {}
		for (method in Reflect.fields(prototype)) {
			untyped rawLuantiPrototype[method] = Reflect.getProperty(prototype, method);
		}
		register_entity(name, rawLuantiPrototype);
	}

	// fixme: this is incorrect.
	@:native("request_shutdown")
	static function requestShutdown(?message: String, ?reconnect: Bool, ?delay: Float): Void;

	// fixme: this is incorrect.
	@:native("register_on_joinplayer")
	static function registerOnJoinPlayer(delegate: () -> Void): Void;
}

@:native("")
extern class Global {
	static function dump(a: Rest<Any>): String;
	static function dump2(a: Rest<Any>): String;
}
