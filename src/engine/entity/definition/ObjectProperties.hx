package src.engine.entity.definition;

class ObjectProperties {
	@:native("hp_max")
	public var hpMax: Int;

	var physical: Bool;

	@:native("collide_with_objects")
	var collideWithObjects: Bool;
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
