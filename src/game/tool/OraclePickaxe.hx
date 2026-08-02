package src.game.tool;

import src.engine.ItemStack;
import src.engine.NodeTable;
import src.engine.definition.NodeDefinition.MAX_NODE_LEVEL;
import src.engine.definition.ToolDefinition;
import src.engine.definition.basic.DigParams;
import src.engine.definition.basic.ToolCapabilities;
import src.engine.entity.objectref.ObjectRefBase;

@:register("infdev:oracle_pickaxe")
final class OraclePickaxe extends ToolDefinition {
	public function new() {
		super();

		this.description = "Oracle Pickaxe";

		this.inventoryImage = "infdev_oracle_pickaxe.png";
		this.wieldImage = "infdev_oracle_pickaxe.png";

		this.toolCapabilities = new ToolCapabilities()
			.setMaxDropLevel(0)
			.addGroupCap(NodeGroupStone, new GroupCapabilities(0.1, 0.005, MAX_NODE_LEVEL, 1_000_000));
	}

	override function afterUse(itemstack: ItemStack, user: Null<ObjectRefBase>, node: NodeTable, digparams: DigParams): Null<ItemStack> {
		trace("I can still use this hooray!");
		return super.afterUse(itemstack, user, node, digparams);
	}
}
