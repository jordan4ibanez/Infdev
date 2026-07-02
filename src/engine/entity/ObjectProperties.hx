package src.engine.entity;

import src.engine.entity.definition.EntityVisual;
import src.engine.entity.definition.EntitySelectionBox;
import src.engine.entity.definition.EntityCollisionBox;

class ObjectProperties {
	@:native("hp_max")
	public var hpMax: Int;

	public var physical: Bool;

	@:native("collide_with_objects")
	public var collideWithObjects: Bool;

	@:native("collisionbox")
	public var collisionBox: EntityCollisionBox;

	@:native("selectionbox")
	public var selectionBox: EntitySelectionBox;

	public var pointable: Bool;

	public var visual: EntityVisual;

	@:native("wield_item")
	public var wieldItem: String;
}

class ObjectPropertiesPlayer extends ObjectProperties {
	@:native("breath_max")
	public var breathMax: Int;

	@:native("zoom_fov")
	public var zoomFOV: Float;

	@:native("eye_height")
	public var eyeHeight: Float;
}

class ObjectPropertiesEntity extends ObjectProperties {}
