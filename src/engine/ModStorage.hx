package src.engine;

import haxe.Constraints.Constructible;
import luantitypes.Core;
import engine.metadata.StorageRef;

final class ModStorage {
	private static var storage: StorageRef;

	static function __init__() {
		storage = Core.getModStorage();
		trace("modstorage gotten");
	}

	public static function getString(key: String): String {
		return storage.getString(key);
	}

	public static function setString(key: String, value: String): Void {
		storage.setString(key, value);
	}

	public static function getFloat(key: String): Float {
		return storage.getFloat(key);
	}

	public static function setFloat(key: String, value: Float): Void {
		storage.setFloat(key, value);
	}

	@:generic
	public static function getClass<T: Constructible<() -> Void>>(key: String): T {
		var output = new T();

		final serial = storage.getString(key);

		trace(serial);

		final rawData = Core.deserialize(serial);

		trace(rawData);

		return output;
	}

	public static function setClass(key: String, value: Dynamic): Void {
		storage.setString(key, Core.serialize(value));
	}
}
