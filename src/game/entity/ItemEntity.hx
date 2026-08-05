package src.game.entity;

import src.engine.ItemStack;
import src.engine.entity.LuaEntity;

@:register(":__builtin:item")
class ItemEntity extends LuaEntity {
	@:native("set_item")
	// todo: make a custom core.spawn_item so this doesn't need a native tag.
	// todo: also this seems to be willy nilly with the string or ItemStack so fix that.
	function setItem(itemName: String): Void {
		var stack = ItemStack.create(itemName);
		untyped print(stack.getName());
		// untyped print(newItem.getName());
	}
}
