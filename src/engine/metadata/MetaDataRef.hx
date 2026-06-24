package src.engine.metadata;

import luantitypes.LuaArray;
import lua.Table;

abstract class MetaDataRef {
	@:native("contains")
	public abstract function contains(key: String): Bool;

	@:native("get")
	public abstract function get<T>(key: String): Null<Dynamic<T>>;

	@:native("set_string")
	public abstract function setString(key: String, value: String): Void;

	@:native("get_string")
	public abstract function getString(key: String): String;

	@:native("set_int")
	public abstract function setInt(key: String, int: Int): Void;

	@:native("get_int")
	public abstract function getInt(key: String): Int;

	@:native("set_float")
	public abstract function setFloat(key: String, float: Float): Void;

	@:native("get_float")
	public abstract function getFloat(key: String): Float;

	@:native("get_keys")
	public abstract function getKeys(): LuaArray<String>;

	@:native("to_table")
	public abstract function toTable(): Table<Dynamic, Dynamic>;

	@:native("from_table")
	public abstract function fromTable(table: Dynamic): Bool;

	@:native("equals")
	public abstract function equals(other: MetaDataRef): Bool;
}
