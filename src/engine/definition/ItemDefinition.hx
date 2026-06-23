package engine.definition;

import engine.definition.basic.DigParams;
import engine.definition.basic.Pointabilities;
import luantitypes.Core;
import engine.definition.graphics.WearBarColors;
import engine.entity.objectref.ObjectRefBase;
import engine.definition.sound.ItemSoundTable;
import engine.vector.EngineVector3;
import engine.definition.graphics.ItemImageDefinition;

/**
 * When you extend this class, you get a specialty class which is extremely interesting.
 * 
 * The extended class is wrapped in a static class.
 * 
 * Defined vars are all copied to the static class. (They are virtual final)
 * 
 * Defined methods are copied to the static class and wrapped in static methods.
 * 
 * ! Warning: Do not call an override API method unless you define it. It doesn't exist.
 * 
 * Feel free to edit your custom vars during runtime.
 * 
 * Never call another override function unless 
 * 
 * Also another note: This one is for items. 
 * Use the ToolDefinition class for tools.
 * Use the NodeDefinition class for nodes.
 */
@:build(luantitypes.ItemDefinitionDuctTape.build())
@:autoBuild(luantitypes.ItemDefinitionDuctTape.build())
@:luantiDefinitionRoot
class ItemDefinition {
	public var description: String;

	@:native("short_description")
	public var shortDescription: String;

	public var groups: Dynamic<Int>;

	@:native("inventory_image")
	public var inventoryImage: ItemImageDefinitionOrString;

	@:native("inventory_overlay")
	public var inventoryOverlay: ItemImageDefinitionOrString;

	@:native("wield_image")
	public var wieldImage: ItemImageDefinitionOrString;

	@:native("wield_overlay")
	public var wieldOverLay: ItemImageDefinitionOrString;

	@:native("wield_scale")
	public var wieldScale: EngineVector3;

	public var palette: String;

	/**
	 * This one is for tools and items.
	 */
	@:native("color")
	public var itemColor: String;

	@:native("stack_max")
	public var stackMax: Int;

	public var range: Float;

	@:native("liquids_pointable")
	public var liquidsPointable: Bool;

	public var pointabilities: Pointabilities;

	@:native("light_source")
	public var lightSource: Int;

	@:native("tool_capabilities")
	public var toolCapabilities: ToolCapabilities;

	@:native("wear_color")
	public var wearColor: WearBarColors;

	@:native("node_placement_prediction")
	public var nodePlacementPrediction: String;

	@:native("node_dig_prediction")
	public var nodeDigPrediction: String;

	@:native("touch_interaction")
	public var touchInteraction: TouchInteractionSetting;

	/**
	 * This one is for tools and items.
	 */
	@:native("sound")
	public var itemSounds: ItemSoundTable;

	@:native("on_place")
	public function onPlace(itemstack: ItemStack, placer: Null<ObjectRefBase>, pointedThing: PointedThing): Null<ItemStack> {
		return Core.itemPlace(itemstack, placer, pointedThing).itemstack;
	};

	@:native("on_secondary_use")
	public function onSecondaryUse(itemstack: ItemStack, user: Null<ObjectRefBase>, pointedThing: PointedThing): Null<ItemStack> {
		return Core.itemSecondaryUse(itemstack, user);
	};

	@:native("on_drop")
	public function onDrop(itemstack: ItemStack, dropper: Null<ObjectRefBase>, pos: EngineVector3): Null<ItemStack> {
		return Core.itemDrop(itemstack, dropper, pos).itemstack;
	};

	@:native("on_pickup")
	public function onPickup(itemstack: ItemStack, picker: Null<ObjectRefBase>, pointedThing: PointedThing, timeFromLastPunch: Float): Null<ItemStack> {
		return Core.itemPickup(itemstack, picker, pointedThing, timeFromLastPunch);
	};

	@:native("on_use")
	public function onUse(itemstack: ItemStack, user: Null<ObjectRefBase>, pointedThing: PointedThing): Null<ItemStack> {
		// nil
		// note: this messes with punching and digging.
		return null;
	};

	@:native("after_use")
	public function afterUse(itemstack: ItemStack, user: Null<ObjectRefBase>, node: NodeTable, digparams: DigParams): Null<ItemStack> {
		// nil
		return null;
	};

	// public var testing: () -> Void;
	// _custom_field = whatever,
	public function new() {
		// trace("triggered itemdefinition constructor");
	}
}
