package luanti_types;

// These are public imports. :)
import luanti_types.LogLevel;

@:native("core")
extern class Core {
	static function log(level:LogLevel, text:String):Void;

	@:native("register_entity")
	static function registerEntity(name:String, prototype:Dynamic):Void;
}
