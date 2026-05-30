package;

enum abstract LogLevel(String) to String {
	var none;
	var error;
	var warning;
	var action;
	var info;
	var verbose;
}

@:native("core")
extern class Luanti {
	static function log(level:LogLevel, text:String):Void;
}
