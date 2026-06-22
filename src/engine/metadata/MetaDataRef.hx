package engine.metadata;

import luantitypes.LuaArray;
import lua.Table;

abstract class MetaDataRef {
	@:native("contains")
	abstract public function contains(key: String): Bool;

	@:native("get")
	abstract public function get<T>(key: String): Null<Dynamic<T>>;

	@:native("set_string")
	abstract public function setString(key: String, value: String): Void;

	@:native("get_string")
	abstract public function getString(key: String): String;

	@:native("set_int")
	abstract public function setInt(key: String, int: Int): Void;

	@:native("get_int")
	abstract public function getInt(key: String): Int;

	@:native("set_float")
	abstract public function setFloat(key: String, float: Float): Void;

	@:native("get_float")
	abstract public function getFloat(key: String): Float;

	@:native("get_keys")
	abstract public function getKeys(): LuaArray<String>;

	@:native("to_table")
	abstract public function toTable(): Table<Dynamic, Dynamic>;

	@:native("from_table")
	abstract public function fromTable(table: Dynamic): Bool;

	@:native("equals")
	abstract public function equals(other: MetaDataRef): Bool;
}
