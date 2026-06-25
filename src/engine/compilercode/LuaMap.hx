package src.engine.compilercode;

import lua.Table;

// This is AI generated.
abstract LuaMap<K, V>(Table<K, V>) from Table<K, V> to Table<K, V> {
	inline public function new() {
		this = Table.create();
	}

	// Allows you to use map['key'] = value syntax.

	@:arrayAccess
	inline public function set(key: K, value: V): V {
		// Direct assignment on the underlying table.
		this[cast key] = value;
		return value;
	}

	// Allows you to use var x = map['key'] syntax.

	@:arrayAccess
	inline public function get(key: K): Null<V> {
		// Direct access on the underlying table.
		return this[cast key];
	}

	// Explicitly cast it to a raw Lua Table when passing to Lua.
	inline public function toLuaTable(): Table<K, V> {
		return this;
	}

	// Automatically convert a standard Haxe Map if you give it one.

	@:from
	public static function fromHaxeMap<K, V>(map: Map<K, V>): LuaMap<K, V> {
		var luaTable = Table.create();
		for (key => value in map) {
			luaTable[cast key] = value;
		}
		return cast luaTable;
	}
}
