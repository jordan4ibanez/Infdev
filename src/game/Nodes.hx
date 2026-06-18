package game;

import haxe.extern.EitherType;
import engine.definition.PointedThing;
import engine.entity.objectref.ObjectRefBase;
import engine.ItemStack;
import engine.definition.TouchInteractionSetting;
import engine.definition.sound.ItemSoundTable;
import engine.definition.images.WearBarColors;
import engine.definition.ToolCapabilities;
import engine.definition.Pointabilities;
import engine.vector.EngineVector3;
import engine.definition.images.ItemImageDefinition.ItemImageDefinitionOrString;
import engine.definition.ItemDefinition;

@:luantiNode("infdev:dirt")
class Dirt extends ItemDefinition {
	public function new() {
		super();

		// this.wieldImage = "test.png";
		// this.wieldOverLay = "test2.png";
		this.color = "test";
		this.afterUse = (itemstack, _, _, _) -> {
			trace("test");

			return null;
		};
	}
}
