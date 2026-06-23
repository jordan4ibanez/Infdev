package game;

import engine.ItemStack;
import engine.entity.objectref.ObjectRefBase;
import engine.NodeTable;
import engine.definition.ItemDefinition;



@:register("infdev:stick")
final class Stick extends ItemDefinition {
	public function new() {
		super();

		// toolCapabilities.addGroupCap()
	}

	override function afterUse(itemstack: ItemStack, user: Null<ObjectRefBase>, node: NodeTable, digparams: Dynamic): Null<ItemStack> {
		return super.afterUse(itemstack, user, node, digparams);
		trace("hmmm");
	}
}
