package src.engine.entity;

import haxe.extern.EitherType;
import src.engine.compilercode.LuaArray;
import src.engine.definition.graphics.ColorSpec;
import src.engine.entity.definition.EntityCollisionBox;
import src.engine.entity.definition.EntityPointable;
import src.engine.entity.definition.EntitySelectionBox;
import src.engine.entity.definition.EntityVisual;
import src.engine.entity.definition.StepUpMode;
import src.engine.vector.EngineVector2;

// todo: builder pattern setters.
class ObjectProperties {
	@:native("hp_max")
	public var hpMax: Int; //!

	public var physical: Bool; //!

	@:native("collide_with_objects")
	public var collideWithObjects: Bool; //!

	@:native("collisionbox")
	public var collisionBox: EntityCollisionBox; //!

	@:native("selectionbox")
	public var selectionBox: EntitySelectionBox; //!

	public var pointable: EntityPointable; //!

	public var visual: EntityVisual; //!

	@:native("wield_item")
	public var wieldItem: String; //!

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

	@:native("automatic_face_movement_dir")
	public var automaticFaceMovementDir: EitherType<Float, Bool>;

	@:native("automatic_face_movement_max_rotation_per_sec")
	public var automaticFaceMovementMaxRotationPerSec: Float;

	@:native("backface_culling")
	public var backfaceCulling: Bool;

	public var glow: Int;

	public var nametag: String;

	@:native("nametag_color")
	public var nametagColor: ColorSpec;

	@:native("nametag_bgcolor")
	public var nametagBackgroundColor: EitherType<ColorSpec, Bool>;

	@:native("nametag_fontsize")
	public var nametagFontSize: EitherType<Int, Bool>;

	/**
	 * The further away the object is, the smaller the nametag becomes.
	 */
	@:native("nametag_scale_z")
	public var nametagScaleZ: Bool;

	@:native("infotext")
	public var infoText: String;

	@:native("static_save")
	public var staticSave: Bool;

	@:native("damage_texture_modifier")
	public var damageTextureModifier: String;

	public var shaded: Bool;

	@:native("show_on_minimap")
	public var showOnMinimap: Bool;

	@:native("step_up_mode")
	public var stepUpMode: StepUpMode;

	@:native("breath_max")
	public var breathMax: Int;

	@:native("zoom_fov")
	public var zoomFOV: Float;

	@:native("eye_height")
	public var eyeHeight: Float;

	public inline function setHPMax (hpMax: Int ): ObjectProperties {
		this.hpMax = hpMax;
		return this;
	}
	
	public inline function setPhysical (physical: Bool ): ObjectProperties {
		this.physical = physical;
		return this;
	}
	
	public inline function setCollideWithObjects (collideWithObjects: Bool ): ObjectProperties {
		this.collideWithObjects = collideWithObjects;
		return this;
	}
	
	public inline function setCollisionBox (collisionBox: EntityCollisionBox ): ObjectProperties {
		this.collisionBox = collisionBox;
		return this;
	}
	
	public inline function setSelectionBox (selectionBox: EntitySelectionBox ): ObjectProperties {
		this.selectionBox = selectionBox;
		return this;
	}
	
	public inline function setPointable (pointable: EntityPointable ): ObjectProperties {
		this.pointable = pointable;
		return this;
	}
	
	public inline function setVisual (visual: EntityVisual ): ObjectProperties {
		this.visual = visual;
		return this;
	}
	
	public inline function setWieldItem (wieldItem: String ): ObjectProperties {
		this.wieldItem = wieldItem;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
	public inline function set (value: ): ObjectProperties {
		this. = value;
		return this;
	}
	
}
