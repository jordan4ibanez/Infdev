package game;

import engine.definition.ToolDefinition;
import engine.definition.PointedThing;
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
final class Hand extends ToolDefinition {
	public function new() {
		super();
		wieldScale = new Vec3(1, 1, 1);
		this.itemColor = "white";
		this.toolCapabilities = new ToolCapabilities()
			.setFullPunchInterval(1.0)
			.addGroupCap("oddly_breakable_by_hand", new GroupCapabilities()
				.setTimesFromArray([3.0, 2.0, 1.0])
				.setMaxLevel(0)
				.setUses(0));
	}
}

@:register("infdev:stick")
final class Stick extends ToolDefinition {
	public function new() {
		super();

		this.inventoryImage = "debug_oracle.png";
		this.wieldImage = "debug_oracle.png";

		this.toolCapabilities = new ToolCapabilities()
			.setFullPunchInterval(1.0)
			.setMaxDropLevel(0)
			.addGroupCap("dirt", new GroupCapabilities()
				.setTimesFromArray([1.0, 0.5, 0.75])
				.setUses(10)
				.setMaxLevel(0));
		Lua.print(Global.dump(this.toolCapabilities));
	}

	override function afterUse(itemstack: ItemStack, user: Null<ObjectRefBase>, node: NodeTable, digparams: Dynamic): Null<ItemStack> {
		trace(itemstack.getWear());
		return itemstack;
	}
}
