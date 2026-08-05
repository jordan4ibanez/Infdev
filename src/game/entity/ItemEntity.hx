package src.game.entity;

import src.engine.ItemStack;
import src.engine.entity.LuaEntity;

@:register(":__builtin:item")
class ItemEntity extends LuaEntity {
	@:native("set_item")
	public function setItem(item: String): Void {
		var stack = ItemStack.create(item);
		untyped print(stack.getName(), stack.getCount());
		// untyped print(newItem.getName());
	}
}
