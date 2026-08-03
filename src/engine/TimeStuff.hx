package src.engine;

// This is AI assisted.
@:final
abstract class TimeStuff {
	public static function getTime(): String {
		var usTime = Core.getUSTime();
		var totalSeconds: Int = lua.Math.floor(usTime / 1000000);
		var hours: Int = lua.Math.floor(totalSeconds / 3600);
		var minutes: Int = lua.Math.floor((totalSeconds % 3600) / 60);
		var seconds: Int = totalSeconds % 60;
		return untyped __lua__('string.format("%02d:%02d:%02d", {0}, {1}, {2})', hours, minutes, seconds);
	}
}
