package luantitypes;

import entity.ObjectRefBase;
import vector.EngineVector3;
import entity.LuaEntity;
import haxe.Rest;
import Reflect;
// These are public imports. :)
import luantitypes.LogLevel;

@:native("core")
extern class Core {
	static function log(level: LogLevel, text: String): Void;

	// This is the real function.
	public static extern function register_entity(name: String, prototype: Dynamic): Void;

	// This is the hijacked function.
	static public inline function registerEntity(name: String, clazz: Class<LuaEntity>): Void {
		var rawLuantiPrototype: Dynamic = {}
		// ? Works from the current class backwards until reached root (Entity).
		var currentClass: Class<Dynamic> = clazz;
		while (currentClass != null) {
			// trace("in class: " + Type.getClassName(currentClass));
			// Class components.
			var prototype = Reflect.field(currentClass, "prototype");
			for (method in Reflect.fields(prototype)) {
				untyped {
					if (rawLuantiPrototype[method] != null) {
						// trace("skipping method " + method + " already has it from child class");
						continue;
					}
					rawLuantiPrototype[method] = Reflect.getProperty(prototype, method);
				}
				// trace(method);
			}
			// Move up the inheritance tree.
			currentClass = Type.getSuperClass(currentClass);
		}
		Core.register_entity(name, rawLuantiPrototype);
	}

	// fixme: this is incorrect.
	@:native("request_shutdown")
	static function requestShutdown(?message: String, ?reconnect: Bool, ?delay: Float): Void;

	// fixme: this is incorrect.
	@:native("register_on_joinplayer")
	static function registerOnJoinPlayer(delegate: () -> Void): Void;

	@:native("get_objects_inside_radius")
	static function getObjectsInsideRadius(center: EngineVector3, radius: Float): LuaArray<ObjectRefBase>;
}

@:native("")
extern class Global {
	static function dump(a: Rest<Any>): String;
	static function dump2(a: Rest<Any>): String;
}
