package src.game.node.plant;

import src.engine.Core;
import src.engine.ItemStack;
import src.engine.definition.NodeDefinition;
import src.engine.definition.basic.PointedThing;
import src.engine.entity.objectref.ObjectRefBase;
import src.game.groups.NodeGroup;

@:register("infdev:cactus")
final class Cactus extends NodeDefinition {
	public function new() {
		super();

		this.description = "Cactus";

		this.tiles = [
			"default_cactus_side.png",
			"default_cactus_top.png",
			"default_cactus_side.png",
		];

		this.nodePlacementPrediction = "";

		this.nodeGroups = [
			NodeGroupPlant => 1,
			NodeGroupAttachedNode => AttachedNodeSettingAlwaysToBelow
		];

		this.nodeSounds = PlantSound.get();
	}

	override function onPlace(itemstack: ItemStack, placer: Null<ObjectRefBase>, pointedThing: PointedThing): Null<ItemStack> {
		// Only allow placing on sand and not itself because farms get very annoying with that.
		if (pointedThing.type == PointedThingTypeNode) {
			var pos = pointedThing.above.copy();
			pos.y -= 1;
			var nodeUnder = Core.getNode(pos);
			if (Core.getItemGroup(nodeUnder.name, NodeGroupSand) > 0) {
				return Core.itemPlace(itemstack, placer, pointedThing).itemstack;
			}
		}
		return null;
	}
}
