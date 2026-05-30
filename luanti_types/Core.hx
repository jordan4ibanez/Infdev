package luanti_types;

// These are public imports. :)
import luanti_types.LogLevel;

@:native("core")
extern class Core {
	static function log(level:LogLevel, text:String):Void;
}
