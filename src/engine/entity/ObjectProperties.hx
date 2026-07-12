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
import src.engine.vector.Vec3;

class ObjectProperties {
	@:native("hp_max")
	public var hpMax: Int;

	@:native("breath_max")
	public var breathMax: Int;

	@:native("zoom_fov")
	public var zoomFOV: Float;

	@:native("eye_height")
	public var eyeHeight: Float;

	public var physical: Bool;

	@:native("collide_with_objects")
	public var collideWithObjects: Bool;

	@:native("collisionbox")
	public var collisionBox: EntityCollisionBox;

	@:native("selectionbox")
	public var selectionBox: EntitySelectionBox;

	public var pointable: EntityPointable;

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

	public inline function setHPMax(hpMax: Int): ObjectProperties {
		this.hpMax = hpMax;
		return this;
	}

	public inline function setBreathMax(breathMax: Int): ObjectProperties {
		this.breathMax = breathMax;
		return this;
	}

	public inline function setZoomFOV(zoomFOV: Float): ObjectProperties {
		this.zoomFOV = zoomFOV;
		return this;
	}

	public inline function setEyeHeight(eyeHeight: Float): ObjectProperties {
		this.eyeHeight = eyeHeight;
		return this;
	}

	public inline function setPhysical(physical: Bool): ObjectProperties {
		this.physical = physical;
		return this;
	}

	public inline function setCollideWithObjects(collideWithObjects: Bool): ObjectProperties {
		this.collideWithObjects = collideWithObjects;
		return this;
	}

	public inline function setCollisionBox(collisionBox: EntityCollisionBox): ObjectProperties {
		this.collisionBox = collisionBox;
		return this;
	}

	public inline function setSelectionBox(selectionBox: EntitySelectionBox): ObjectProperties {
		this.selectionBox = selectionBox;
		return this;
	}

	public inline function setPointable(pointable: EntityPointable): ObjectProperties {
		this.pointable = pointable;
		return this;
	}

	public inline function setVisual(visual: EntityVisual): ObjectProperties {
		this.visual = visual;
		return this;
	}

	public inline function setWieldItem(wieldItem: String): ObjectProperties {
		this.wieldItem = wieldItem;
		return this;
	}

	public inline function setVisualSize(visualSize: EitherType<EngineVector2, Vec3>): ObjectProperties {
		this.visualSize = visualSize;
		return this;
	}

	public inline function setMesh(mesh: String): ObjectProperties {
		this.mesh = mesh;
		return this;
	}

	public inline function setTextures(textures: LuaArray<String>): ObjectProperties {
		this.textures = textures;
		return this;
	}

	public inline function setColors(colors: LuaArray<ColorSpec>): ObjectProperties {
		this.colors = colors;
		return this;
	}

	public inline function setNode(node: NodeTable): ObjectProperties {
		this.node = node;
		return this;
	}

	public inline function setUseTextureAlpha(useTextureAlpha: Bool): ObjectProperties {
		this.useTextureAlpha = useTextureAlpha;
		return this;
	}

	public inline function setSpriteDiv(spriteDiv: EngineVector2): ObjectProperties {
		this.spriteDiv = spriteDiv;
		return this;
	}

	public inline function setInitialSpriteBasePos(initialSpriteBasePos: EngineVector2): ObjectProperties {
		this.initialSpriteBasePos = initialSpriteBasePos;
		return this;
	}

	public inline function setIsVisible(isVisible: Bool): ObjectProperties {
		this.isVisible = isVisible;
		return this;
	}

	public inline function setMakesFootstepSound(makesFootstepSound: Bool): ObjectProperties {
		this.makesFootstepSound = makesFootstepSound;
		return this;
	}

	public inline function setAutomaticRotate(automaticRotate: Float): ObjectProperties {
		this.automaticRotate = automaticRotate;
		return this;
	}

	public inline function setStepHeight(stepHeight: Float): ObjectProperties {
		this.stepHeight = stepHeight;
		return this;
	}

	public inline function setAutomaticFaceMovementDir(automaticFaceMovementDir: EitherType<Float, Bool>): ObjectProperties {
		this.automaticFaceMovementDir = automaticFaceMovementDir;
		return this;
	}

	public inline function setAutomaticFaceMovementMaxRotationPerSec(automaticFaceMovementMaxRotationPerSec: Float): ObjectProperties {
		this.automaticFaceMovementMaxRotationPerSec = automaticFaceMovementMaxRotationPerSec;
		return this;
	}

	public inline function setBackfaceCulling(backfaceCulling: Bool): ObjectProperties {
		this.backfaceCulling = backfaceCulling;
		return this;
	}

	public inline function setGlow(glow: Int): ObjectProperties {
		this.glow = glow;
		return this;
	}

	public inline function setNametag(nametag: String): ObjectProperties {
		this.nametag = nametag;
		return this;
	}

	public inline function setNametagColor(nametagColor: ColorSpec): ObjectProperties {
		this.nametagColor = nametagColor;
		return this;
	}

	public inline function setNametagBackgroundColor(nametagBackgroundColor: EitherType<ColorSpec, Bool>): ObjectProperties {
		this.nametagBackgroundColor = nametagBackgroundColor;
		return this;
	}

	public inline function setNametagFontSize(nametagFontSize: EitherType<Int, Bool>): ObjectProperties {
		this.nametagFontSize = nametagFontSize;
		return this;
	}

	public inline function setNametagScaleZ(nametagScaleZ: Bool): ObjectProperties {
		this.nametagScaleZ = nametagScaleZ;
		return this;
	}

	public inline function setInfoText(infoText: String): ObjectProperties {
		this.infoText = infoText;
		return this;
	}

	public inline function setStaticSave(staticSave: Bool): ObjectProperties {
		this.staticSave = staticSave;
		return this;
	}

	public inline function setDamageTextureModifier(damageTextureModifier: String): ObjectProperties {
		this.damageTextureModifier = damageTextureModifier;
		return this;
	}

	public inline function setShaded(shaded: Bool): ObjectProperties {
		this.shaded = shaded;
		return this;
	}

	public inline function setShowOnMinimap(showOnMinimap: Bool): ObjectProperties {
		this.showOnMinimap = showOnMinimap;
		return this;
	}

	public inline function setStepUpMode(stepUpMode: StepUpMode): ObjectProperties {
		this.stepUpMode = stepUpMode;
		return this;
	}

	public function new() {}
}
