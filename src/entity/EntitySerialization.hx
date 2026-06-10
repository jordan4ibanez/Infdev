package entity;

import luantitypes.Core;

final class EntitySerialization {
	/**
	 * This was made to clone core.deserialize data into a haxe class with defaults to make it nice as possible.
	 * @param cloneFrom Output from core.deserialize.
	 * @param cloneTo The class you want to write this data into.
	 * @return T The storage type you're using for the data in this class.
	 */
	public static function safeDeserialize<T>(staticData: String, outputObject: Dynamic, clazz: Class<T>): Void {
		var containerClass;

		var autoDetectClass = Type.getClass(outputObject);

		// I have no idea why this works this way but it does.

		// This is a Non-player.
		if (autoDetectClass == null) {
			containerClass = Type.createInstance(clazz, []);
		} else {
			// This is a player.
			containerClass = Type.createInstance(autoDetectClass, []);
		}

		final deserializedTable = Core.deserialize(staticData);

		// If it doesn't equal null then start the clone.
		if (deserializedTable != null) {
			// Clone from the core.deserialize output into a haxe container class first.
			for (field in Reflect.fields(containerClass)) {
				untyped {
					// Don't clone null data.
					if (deserializedTable[field] == null) {
						continue;
					}
					// This is decorated by the engine. (And not protected by it)
					if (field == "object" || field == "name") {
						continue;
					}
					containerClass[field] = deserializedTable[field];
				}
				trace("first pass", field);
			}
		}

		// ? Debugging.
		// trace(containerClass);

		// Clone from the haxe container class into the the full class next.
		for (field in Reflect.fields(containerClass)) {
			// This is decorated by the engine. (And not protected by it)
			if (field == "object" || field == "name") {
				continue;
			}
			untyped {
				outputObject[field] = containerClass[field];
			}
			trace("second pass", field);
		}
	}

	public static function safeSerialize<T>(inputObject: Dynamic, clazz: Class<T>): String {
		var containerClass;

		var autoDetectClass = Type.getClass(inputObject);

		// I have no idea why this works this way but it does.

		// This is a Non-player.
		if (autoDetectClass == null) {
			containerClass = Type.createInstance(clazz, []);
		} else {
			// This is a player.
			containerClass = Type.createInstance(autoDetectClass, []);
		}

		// todo: clone the data into a new object minus the name and the userdata
		// todo: if (field == "object" || field == "name") {
		// todo: 	continue;
		// todo: }

		return "";
	}
}
