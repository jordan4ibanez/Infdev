package src.game.tool;

import src.engine.ItemStack;
import src.engine.NodeTable;
import src.engine.definition.ToolCapabilities;
import src.engine.definition.ToolDefinition;
import src.engine.definition.basic.DigParams;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.vector.Vec3;
import src.game.groups.NodeGroup.BEDROCK;

@:register("infdev:oracle_pickaxe")
final class OraclePickaxe extends ToolDefinition {
	public function new() {
		super();

		this.inventoryImage = "debug_oracle.png";
		this.wieldImage = "debug_oracle.png";

		this.toolCapabilities = new ToolCapabilities()
			.setFullPunchInterval(1.0)
			.setMaxDropLevel(0)
			.addGroupCap(NodeGroupDirt, new GroupCapabilities()
				.setTimesFromArray([1.0, 0.5, 0.75])
				.setUses(10)
				.setMaxLevel(0));
	}

	override function afterUse(itemstack: ItemStack, user: Null<ObjectRefBase>, node: NodeTable, digparams: DigParams): Null<ItemStack> {
		trace("I can still use this hooray!");
		return super.afterUse(itemstack, user, node, digparams);
	}
}
