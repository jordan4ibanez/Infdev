package src.engine.entity.helpers;

final class EntitySerialization {
	/**
	 * This was made to clone core.deserialize data into a haxe class with defaults to make it nice as possible.
	 * If the class has userdata in it, it must be set to null or else this will crash.
	 * @param staticData The static data.
	 * @param cloneTo The object you want to write this data into.
	 * @param clazz The class type of outputObject.
	 * @return T The storage type you're using for the data in this class.
	 */
	public static function safeDeserialize<T>(staticData: String, outputObject: Dynamic, clazz: Class<T>): Void {
		// Base defaults.
		var containerClass = Type.createInstance(clazz, []);

		// Saved data.
		final deserializedTable = Serialize.deserialize(staticData);

		// If it doesn't equal null then start the clone.
		if (deserializedTable != null) {
			// Clone from the core.deserialize output into a haxe container class first.
			for (field in Type.getInstanceFields(clazz)) {
				untyped {
					// This is decorated by the engine. (And not protected by it)
					if (field == "object" || field == "name") {
						continue;
					}

					var value = Reflect.field(containerClass, field);

					// Don't serialize functions or userdata.
					var luaType = untyped type(value);
					if (luaType == "function" || luaType == "userdata") {
						continue;
					}
					// untyped print("deserialize", luaType);

					// trace(field, value);
					// ? Debug info.
					// (deserializedTable[field] == null) ? trace("container class", field) : trace("deserialized data", field);

					outputObject[field] = (deserializedTable[field] == null) ? containerClass[field] : deserializedTable[field];
				}
				// trace("first pass", field);
			}
		}
	}

	/**
	 * This was made to clone core.serialize data into a haxe class with defaults to make it nice as possible.
	 * If the class has userdata in it, it must be set to null or else this will crash.
	 * @param inputObject The object you want to turn into a string.
	 * @param clazz The class type of inputObject.
	 * @return String The serialized data string.
	 */
	public static function safeSerialize<T>(inputObject: Dynamic, clazz: Class<T>): String {
		// trace(Type.getInstanceFields(clazz), Type.getClassName(clazz));

		var outputObject: Dynamic = {};

		// Clone from the haxe container class into the the full class next.
		for (field in Type.getInstanceFields(clazz)) {
			// This is decorated by the engine. (And not protected by it)
			if (field == "object" || field == "name") {
				continue;
			}

			var value = Reflect.field(inputObject, field);

			// Don't serialize functions or userdata.
			var luaType = untyped type(value);
			if (luaType == "function" || luaType == "userdata") {
				continue;
			}
			// untyped print("serialize", luaType);

			untyped {
				outputObject[field] = inputObject[field];
			}
			// trace("field", field);
		}

		return Serialize.serialize(outputObject);
	}
}
