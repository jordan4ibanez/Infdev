package src.engine;

import lua.Table;
import src.engine.compilercode.LuaArray;

// todo: this needs a qol boost. Some kind of type conversion or something.
// todo: maybe have this be the base and just implement on top of it or something.
// todo: could have all these things be a base with inlines or something.
// todo: anything is better. Look into this.
@:final
abstract class InvRef {
	@:native("is_empty")
	public abstract function isEmpty(listName: String): Bool;

	@:native("get_size")
	public abstract function getSize(listName: String): Int;

	@:native("set_size")
	public abstract function setSize(listName: String, size: Int): Null<Bool>;

	@:native("get_width")
	public abstract function getWidth(listName: String): Int;

	@:native("set_width")
	public abstract function setWidth(listName: String, width: Int): Null<Bool>;

	@:native("get_stack")
	public abstract function getStack(listName: String, index: Int): ItemStack;

	@:native("set_stack")
	public abstract function setStack(listName: String, index: Int, stack: ItemStack): Void;

	@:native("get_list")
	public abstract function getList(listName: String): Null<Table<Int, ItemStack>>;

	@:native("set_list")
	public abstract function setList(listName: String, list: Table<Int, ItemStack>): Void;

	// This is horrible.

	@:native("get_lists")
	public abstract function getLists(): Table<String, LuaArray<ItemStack>>;

	// This is horrible.

	@:native("set_lists")
	public abstract function setLists(lists: Table<String, LuaArray<ItemStack>>): Void;

	@:native("add_item")
	public abstract function addItem(listName: String, stack: ItemStack): ItemStack;

	@:native("room_for_item")
	public abstract function roomForItem(listName: String, stack: ItemStack): Bool;

	@:native("contains_item")
	public abstract function containsItem(listName: String, stack: ItemStack, ?matchMeta: Bool): Bool;

	@:native("remove_item")
	public abstract function removeItem(listName: String, stack: ItemStack, ?matchMeta: Bool): ItemStack;

	// todo: InventoryLocation

	@:native("get_location")
	public abstract function getLocation(listName: String): Dynamic;

	// todo: example:
	// public inline function doThing() {
	// 	untyped __lua__("self:do_lua_thing()");
	// }
	// todo: implement callbacks, somehow
}
