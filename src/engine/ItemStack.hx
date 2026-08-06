package src.engine;

import haxe.extern.EitherType;
import src.engine.metadata.ItemStackMetaRef;

// todo: getters
// todo: rework this entire thing this is just a bootstrap
// https://github.com/luanti-org/luanti/blob/master/doc/lua_api.md#itemstack
@:final
abstract class ItemStack {
	public static inline function create(itemName: EitherType<String, ItemStack>): ItemStack {
		return untyped __lua__("ItemStack({0})", itemName);
	}

	// todo: put these in order and complete this.

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

	@:native("to_string")
	public abstract function toString(): String;

	@:native("is_known")
	public abstract function isKnown(): Bool;

	@:native("get_stack_max")
	public abstract function getStackMax(): Int;

	@:native("get_description")
	public abstract function getDescription(): String;

	@:native("get_meta")
	public abstract function getMeta(): ItemStackMetaRef;

	@:native("get_free_space")
	public abstract function getFreeSpace(): Int;

	// @:native("")
	// public abstract function setMetadata(metadata: String): Void;
}
