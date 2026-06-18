package engine.definition;

import engine.definition.images.WearBarColors;
import engine.entity.objectref.ObjectRefBase;
import engine.definition.sound.ItemSoundTable;
import engine.vector.EngineVector3;
import engine.definition.images.ItemImageDefinition;

/**
 * When you extend this class, you get a specialty static class which only uses
 * OOP for auto complete. Everything else custom needs to be static. This is enforced.
 * 
 * ItemDefinition is the root of all other definitions. (nodes, craftitem, tool)
 */
@:build(luantitypes.ItemDefinitionDuctTape.build())
@:autoBuild(luantitypes.ItemDefinitionDuctTape.build())
interface ItemDefinition {
	public var description: String;

	@:native("short_description")
	public var shortDescription: String;

	public var groups: Dynamic<Int>;

	@:native("wield_image")
	public var wieldImage: ItemImageDefinitionOrString;

	@:native("wield_overlay")
	public var wieldOverLay: ItemImageDefinitionOrString;

	@:native("wield_scale")
	public var wieldScale: EngineVector3;

	public var palette: String;

	public var color: String;

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

	public var sound: ItemSoundTable;

	// todo: ItemStack
	// todo: PointedThing
	@:native("on_place")
	public var onPlace: (itemstack: Dynamic, placer: Null<ObjectRefBase>, pointedThing: Dynamic) -> Null<Dynamic>;

	@:native("on_secondary_use")
	public var onSecondaryUse: (itemstack: Dynamic, user: Null<ObjectRefBase>, pointedThing: Dynamic) -> Void;

	@:native("on_drop")
	public var onDrop: (itemstack: Dynamic, dropper: Null<ObjectRefBase>, pos: EngineVector3) -> Null<Dynamic>;

	@:native("on_pickup")
	public var onPickup: (itemstack: Dynamic, picker: Null<ObjectRefBase>, pointedThing: Dynamic, timeFromLastPunch: Float) -> Null<Dynamic>;

	@:native("on_use")
	public var onUse: (itemstack: Dynamic, user: Null<ObjectRefBase>, pointedThing: Dynamic) -> Null<Dynamic>;

	// todo: node thing
	// todo: digparams
	@:native("after_use")
	public var afterUse: (itemstack: Dynamic, user: Null<ObjectRefBase>, node: Dynamic, digparams: Dynamic) -> Null<Dynamic>;
	// public var testing: () -> Void;
	// _custom_field = whatever,
}
