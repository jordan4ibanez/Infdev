package src.engine.entity;

import src.engine.compilercode.LuaArray;
import src.engine.definition.graphics.ColorSpec;
import src.engine.entity.definition.EntityCollisionBox;
import src.engine.entity.definition.EntitySelectionBox;
import src.engine.entity.definition.EntityVisual;
import src.engine.vector.EngineVector2;

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

	@:native("visual_size")
	public var visualSize: EngineVector2;

	public var mesh: String;

	public var textures: LuaArray<String>;

	public var colors: LuaArray<ColorSpec>;

	public var node: NodeTable;

	@:native("use_texture_alpha")
	public var useTextureAlpha: Bool;

	@:native("spritediv")
	public var spriteDiv: EngineVector2;

	@:native("initial_sprite_basepos")
	public var initialSpriteBasePos: EngineVector2;

	@:native("is_visible")
	public var isVisible: Bool;

	@:native("makes_footstep_sound")
	public var makesFootstepSound: Bool;

	@:native("automatic_rotate")
	public var automaticRotate: Float;

	@:native("stepheight")
	public var stepHeight: Float;

	
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
