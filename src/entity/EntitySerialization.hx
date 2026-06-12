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
			// trace(Type.getClassName(clazz), "non");
		} else {
			// This is a player.
			containerClass = Type.createInstance(autoDetectClass, []);

			trace(containerClass);
			trace(Type.createInstance(clazz, []));
			// trace(Type.getClassName(clazz), "is");
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
				// trace("first pass", field);
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
			// trace("second pass", field);
		}
	}

	public static function safeSerialize<T>(inputObject: Dynamic, clazz: Class<T>): String {
		// trace(Type.getInstanceFields(clazz), Type.getClassName(clazz));

		// todo: use this method on safeDeserialize!

		var outputObject: Dynamic = {};

		// Clone from the haxe container class into the the full class next.
		for (field in Type.getInstanceFields(clazz)) {
			// This is decorated by the engine. (And not protected by it)
			if (field == "object" || field == "name") {
				continue;
			}

			var value = Reflect.field(inputObject, field);

			// Do not dump methods into the serialized string.
			if (Reflect.isFunction(value)) {
				continue;
			}

			untyped {
				outputObject[field] = inputObject[field];
			}
			trace("field", field);
		}

		return Core.serialize(outputObject);
	}
}
