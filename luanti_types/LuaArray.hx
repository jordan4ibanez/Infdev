package luanti_types;

import lua.Table;

// This was AI generated cause I can't be fucked to figure this out myself.

@:forward
abstract LuaArray<T>(Table<Int, T>) from Table<Int, T> to Table<Int, T> {
	public var length(get, never): Int;

	inline function get_length(): Int {
		return untyped __lua__("#({0})", this);
	}

	@:arrayAccess
	inline function get(index: Int): T {
		return untyped this[index + 1];
	}

	inline public function iterator(): LuaArrayIterator<T> {
		return new LuaArrayIterator(cast this);
	}
}

class LuaArrayIterator<T> {
	var array: LuaArray<T>;
	var index: Int = 0;

	inline public function new(array: LuaArray<T>) {
		this.array = array;
	}

	inline public function hasNext(): Bool {
		return index < array.length;
	}

	inline public function next(): T {
		var value = array[index];
		index++;
		return value;
	}
}
