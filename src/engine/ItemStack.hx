package src.engine;

// todo: getters
// todo: rework this entire thing this is just a bootstrap
// https://github.com/luanti-org/luanti/blob/master/doc/lua_api.md#itemstack
@:final
abstract class ItemStack {
	public static inline function create(itemName: String): ItemStack {
		return untyped __lua__("ItemStack(itemName)");
	}

	@:native("get_name")
	public abstract function getName(): String;

	@:native("set_name")
	public abstract function setName(itemName: String): Void;

	@:native("set_count")
	public abstract function setCount(count: Int): Void;

	@:native("get_count")
	public abstract function getCount(): Int;

	@:native("get_wear")
	public abstract function getWear(): Int;

	@:native("add_wear")
	public abstract function addWear(wear: Int): Void;

	@:native("set_wear")
	public abstract function setWear(wear: Int): Void;

	// @:native("")
	// public abstract function setMetadata(metadata: String): Void;
}
