package game;

import luantitypes.Core.Global;
import lua.Lua;
import engine.definition.ToolCapabilities;
import engine.definition.graphics.WearBarColors;
import engine.vector.Vec3;
import engine.ItemStack;
import engine.entity.objectref.ObjectRefBase;
import engine.NodeTable;
import engine.definition.ItemDefinition;

@:override("")
final class Hand extends ItemDefinition {
	public function new() {
		super();

		wieldScale = new Vec3(1, 1, 1);

		this.itemColor = "white";

		this.toolCapabilities = new ToolCapabilities()
			.setFullPunchInterval(1.0)
			.addGroupCap("oddly_breakable_by_hand", new GroupCapabilities()
				.setTimesFromArray([3.0, 2.0, 3.0])
				.setUses(0));

		// Lua.print(Global.dump(this.toolCapabilities));
	}
}

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
