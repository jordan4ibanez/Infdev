package luanti_types;

import luanti_types.Log.LogLevel;

@:native("core")
extern class Core {
	static function log(level:LogLevel, text:String):Void;
}
