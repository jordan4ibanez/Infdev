package engine;

abstract class InvRef {
	@:native("is_empty")
	public abstract function isEmpty(listName: String): Boolean;

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

	// todo: this needs a qol boost.

	@:native("set_list")
	public abstract function setList(listName: String, list: Table<Int, ItemStack>): Void;

	@:native("get_lists")
	public abstract function getLists(): Table<String, Table<Int, ItemStack>>;

	@:native("set_lists")
	public abstract function setLists(lists: Table<String, Table<Int, ItemStack>>): Void;

	@:native("add_item")
	public abstract function addItem(listName: String, stack: ItemStack): ItemStack;
