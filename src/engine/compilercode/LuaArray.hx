package src.engine.compilercode;

import lua.Table;

// This was AI generated cause I can't be fucked to figure this out myself.

@:forward
abstract LuaArray<T>(Table<Int, T>) from Table<Int, T> to Table<Int, T> {
	// Allows calling: var arr = new LuaArray<String>();
	inline public function new() {
		this = Table.create();
	}

	// Syntactic sugar alternative: var arr = LuaArray.create();
	inline public static function create<T>(): LuaArray<T> {
		return new LuaArray<T>();
	}

	public var length(get, never): Int;

	inline function get_length(): Int {
		return untyped __lua__("#({0})", this);
	}

	// Appends an item to the end of the Lua array (1-indexed safe)
	inline public function push(value: T): Void {
		untyped this[get_length() + 1] = value;
	}

	// Allows implicit casting: var la: LuaArray<Int> = [1, 2, 3];

	@:from
	public static inline function fromArray<T>(arr: Array<T>): LuaArray<T> {
		return cast Table.fromArray(arr);
	}

	@:arrayAccess
	inline function get(index: Int): T {
		return untyped this[index + 1];
	}

	// Adding array write access so you can actually populate it

	@:arrayAccess
	inline function set(index: Int, value: T): T {
		untyped this[index + 1] = value;
		return value;
	}

	inline public function iterator(): LuaArrayIterator<T> {
		return new LuaArrayIterator(cast this);
	}

	inline public function keyValueIterator(): LuaArrayKeyValueIterator<T> {
		return new LuaArrayKeyValueIterator(cast this);
	}
}

class LuaArrayKeyValueIterator<T> {
	var array: LuaArray<T>;
	var index: Int = 0;

	inline public function new(array: LuaArray<T>) {
		this.array = array;
	}

	inline public function hasNext(): Bool {
		return index < array.length;
	}

	inline public function next(): {key: Int, value: T} {
		var value = array[index];
		var result = {key: index, value: value};
		index++;
		return result;
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
