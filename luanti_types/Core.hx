package luanti_types;

// These are public imports. :)
import luanti_types.LogLevel;

@:native("core")
extern class Core {
	static function log(level:LogLevel, text:String):Void;

	// fixme: this is incorrect.
	@:native("register_entity")
	static function registerEntity(name:String, prototype:Dynamic):Void;

	// fixme: this is incorrect.
	@:native("request_shutdown")
	static function requestShutdown(?message:String, ?reconnect:Bool, ?delay:Float):Void;

	// fixme: this is incorrect.
	@:native("register_on_joinplayer")
	static function registerOnJoinPlayer(delegate:() -> Void):Void;
}
