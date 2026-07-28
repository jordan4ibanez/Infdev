package src.game.node.plant;

import src.engine.Core;
import src.engine.ItemStack;
import src.engine.definition.NodeDefinition;
import src.engine.definition.basic.NodeBox;
import src.engine.definition.basic.PointedThing;
import src.engine.entity.objectref.ObjectRefBase;
import src.game.groups.NodeGroup;

@:register("infdev:sugarcane")
final class Sugarcane extends NodeDefinition {
	public function new() {
		super();

		this.description = "Sugarcane";

		this.tiles = [
			"default_papyrus.png"
		];

		this.nodePlacementPrediction = "";

		this.drawType = DrawTypePlantLike;

		this.paramtype1 = ParamType1Light;

		this.sunlightPropagates = true;

		this.walkable = false;

		this.selectionBox = new NodeBoxFixed()
			.addBox(-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16);

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
