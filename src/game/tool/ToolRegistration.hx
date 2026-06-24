package src.game.tool;

import engine.definition.basic.DigParams;
import engine.NodeTable;
import engine.entity.objectref.ObjectRefBase;
import engine.ItemStack;
import luantitypes.Core.Global;
import lua.Lua;
import engine.definition.ToolCapabilities;
import engine.vector.Vec3;
import engine.definition.ToolDefinition;

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

@:register("infdev:oracle_pickaxe")
final class OraclePickaxe extends ToolDefinition {
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
	}

	override function afterUse(itemstack: ItemStack, user: Null<ObjectRefBase>, node: NodeTable, digparams: DigParams): Null<ItemStack> {
		trace("I can still use this hooray!");
		return super.afterUse(itemstack, user, node, digparams);
	}
}
