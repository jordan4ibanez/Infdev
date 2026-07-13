package src.engine.entity;

import haxe.extern.EitherType;
import src.engine.compilercode.LuaArray;
import src.engine.definition.graphics.ColorSpec;
import src.engine.entity.definition.EntityCollisionBox;
import src.engine.entity.definition.EntityPointable;
import src.engine.entity.definition.EntitySelectionBox;
import src.engine.entity.definition.EntityVisual;
import src.engine.entity.definition.StepUpMode;
import src.engine.vector.Vec2;
import src.engine.vector.Vec3;

typedef ObjectProperties = {
	@:optional
	var hp_max: Int;

	@:optional
	var breath_max: Int;

	@:optional
	var zoom_fov: Float;

	@:optional
	var eye_height: Float;

	@:optional
	var physical: Bool;

	@:optional
	var collide_with_objects: Bool;

	@:optional
	var collisionbox: EntityCollisionBox;

	@:optional
	var selectionbox: EntitySelectionBox;

	@:optional
	var pointable: EntityPointable;

	@:optional
	var visual: EntityVisual;

	@:optional
	var wield_item: String;

	@:optional
	var visual_size: EitherType<Vec2, Vec3>;

	@:optional
	var mesh: String;

	@:optional
	var textures: LuaArray<String>;

	@:optional
	var colors: LuaArray<ColorSpec>;

	@:optional
	var node: NodeTable;

	@:optional
	var use_texture_alpha: Bool;

	@:optional
	var spritediv: Vec2;

	@:optional
	var initial_sprite_basepos: Vec2;

	@:optional
	var is_visible: Bool;

	@:optional
	var makes_footstep_sound: Bool;

	@:optional
	var automatic_rotate: Float;

	@:optional
	var stepheight: Float;

	@:optional
	var automatic_face_movement_dir: EitherType<Float, Bool>;

	@:optional
	var automatic_face_movement_max_rotation_per_sec: Float;

	@:optional
	var backface_culling: Bool;

	@:optional
	var glow: Int;

	@:optional
	var nametag: String;

	@:optional
	var nametag_color: ColorSpec;

	@:optional
	var nametag_bgcolor: EitherType<ColorSpec, Bool>;

	@:optional
	var nametag_fontsize: EitherType<Int, Bool>;

	/**
	 * The further away the object is, the smaller the nametag becomes.
	 */
	@:optional
	var nametag_scale_z: Bool;

	@:optional
	var infotext: String;

	@:optional
	var static_save: Bool;

	@:optional
	var damage_texture_modifier: String;

	@:optional
	var shaded: Bool;

	@:optional
	var show_on_minimap: Bool;

	@:optional
	var step_up_mode: StepUpMode;
	// public inline function setHPMax(hpMax: Int): ObjectProperties {
	// 	this.hpMax = hpMax;
	// 	return this;
	// }
	// public inline function setBreathMax(breathMax: Int): ObjectProperties {
	// 	this.breathMax = breathMax;
	// 	return this;
	// }
	// public inline function setZoomFOV(zoomFOV: Float): ObjectProperties {
	// 	this.zoomFOV = zoomFOV;
	// 	return this;
	// }
	// public inline function setEyeHeight(eyeHeight: Float): ObjectProperties {
	// 	this.eyeHeight = eyeHeight;
	// 	return this;
	// }
	// public inline function setPhysical(physical: Bool): ObjectProperties {
	// 	this.physical = physical;
	// 	return this;
	// }
	// public inline function setCollideWithObjects(collideWithObjects: Bool): ObjectProperties {
	// 	this.collideWithObjects = collideWithObjects;
	// 	return this;
	// }
	// public inline function setCollisionBox(collisionBox: EntityCollisionBox): ObjectProperties {
	// 	this.collisionBox = collisionBox;
	// 	return this;
	// }
	// public inline function setSelectionBox(selectionBox: EntitySelectionBox): ObjectProperties {
	// 	this.selectionBox = selectionBox;
	// 	return this;
	// }
	// public inline function setPointable(pointable: EntityPointable): ObjectProperties {
	// 	this.pointable = pointable;
	// 	return this;
	// }
	// public inline function setVisual(visual: EntityVisual): ObjectProperties {
	// 	this.visual = visual;
	// 	return this;
	// }
	// public inline function setWieldItem(wieldItem: String): ObjectProperties {
	// 	this.wieldItem = wieldItem;
	// 	return this;
	// }
	// public inline function setVisualSize(visualSize: EitherType<Vec2, Vec3>): ObjectProperties {
	// 	this.visualSize = visualSize;
	// 	return this;
	// }
	// public inline function setMesh(mesh: String): ObjectProperties {
	// 	this.mesh = mesh;
	// 	return this;
	// }
	// public inline function setTextures(textures: LuaArray<String>): ObjectProperties {
	// 	this.textures = textures;
	// 	return this;
	// }
	// public inline function setColors(colors: LuaArray<ColorSpec>): ObjectProperties {
	// 	this.colors = colors;
	// 	return this;
	// }
	// public inline function setNode(node: NodeTable): ObjectProperties {
	// 	this.node = node;
	// 	return this;
	// }
	// public inline function setUseTextureAlpha(useTextureAlpha: Bool): ObjectProperties {
	// 	this.useTextureAlpha = useTextureAlpha;
	// 	return this;
	// }
	// public inline function setSpriteDiv(spriteDiv: Vec2): ObjectProperties {
	// 	this.spriteDiv = spriteDiv;
	// 	return this;
	// }
	// public inline function setInitialSpriteBasePos(initialSpriteBasePos: Vec2): ObjectProperties {
	// 	this.initialSpriteBasePos = initialSpriteBasePos;
	// 	return this;
	// }
	// public inline function setIsVisible(isVisible: Bool): ObjectProperties {
	// 	this.isVisible = isVisible;
	// 	return this;
	// }
	// public inline function setMakesFootstepSound(makesFootstepSound: Bool): ObjectProperties {
	// 	this.makesFootstepSound = makesFootstepSound;
	// 	return this;
	// }
	// public inline function setAutomaticRotate(automaticRotate: Float): ObjectProperties {
	// 	this.automaticRotate = automaticRotate;
	// 	return this;
	// }
	// public inline function setStepHeight(stepHeight: Float): ObjectProperties {
	// 	this.stepHeight = stepHeight;
	// 	return this;
	// }
	// public inline function setAutomaticFaceMovementDir(automaticFaceMovementDir: EitherType<Float, Bool>): ObjectProperties {
	// 	this.automaticFaceMovementDir = automaticFaceMovementDir;
	// 	return this;
	// }
	// public inline function setAutomaticFaceMovementMaxRotationPerSec(automaticFaceMovementMaxRotationPerSec: Float): ObjectProperties {
	// 	this.automaticFaceMovementMaxRotationPerSec = automaticFaceMovementMaxRotationPerSec;
	// 	return this;
	// }
	// public inline function setBackfaceCulling(backfaceCulling: Bool): ObjectProperties {
	// 	this.backfaceCulling = backfaceCulling;
	// 	return this;
	// }
	// public inline function setGlow(glow: Int): ObjectProperties {
	// 	this.glow = glow;
	// 	return this;
	// }
	// public inline function setNametag(nametag: String): ObjectProperties {
	// 	this.nametag = nametag;
	// 	return this;
	// }
	// public inline function setNametagColor(nametagColor: ColorSpec): ObjectProperties {
	// 	this.nametagColor = nametagColor;
	// 	return this;
	// }
	// public inline function setNametagBackgroundColor(nametagBackgroundColor: EitherType<ColorSpec, Bool>): ObjectProperties {
	// 	this.nametagBackgroundColor = nametagBackgroundColor;
	// 	return this;
	// }
	// public inline function setNametagFontSize(nametagFontSize: EitherType<Int, Bool>): ObjectProperties {
	// 	this.nametagFontSize = nametagFontSize;
	// 	return this;
	// }
	// public inline function setNametagScaleZ(nametagScaleZ: Bool): ObjectProperties {
	// 	this.nametagScaleZ = nametagScaleZ;
	// 	return this;
	// }
	// public inline function setInfoText(infoText: String): ObjectProperties {
	// 	this.infoText = infoText;
	// 	return this;
	// }
	// public inline function setStaticSave(staticSave: Bool): ObjectProperties {
	// 	this.staticSave = staticSave;
	// 	return this;
	// }
	// public inline function setDamageTextureModifier(damageTextureModifier: String): ObjectProperties {
	// 	this.damageTextureModifier = damageTextureModifier;
	// 	return this;
	// }
	// public inline function setShaded(shaded: Bool): ObjectProperties {
	// 	this.shaded = shaded;
	// 	return this;
	// }
	// public inline function setShowOnMinimap(showOnMinimap: Bool): ObjectProperties {
	// 	this.showOnMinimap = showOnMinimap;
	// 	return this;
	// }
	// public inline function setStepUpMode(stepUpMode: StepUpMode): ObjectProperties {
	// 	this.stepUpMode = stepUpMode;
	// 	return this;
	// }
	// public function new() {}
}
