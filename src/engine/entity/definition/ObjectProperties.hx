package src.engine.entity.definition;

class ObjectProperties {
	@:native("hp_max")
	public var hpMax: Int;

	@:native("breath_max")
	public var breathMax: Int;

	@:native("zoom_fov")
	public var zoomFOV: Float;
}

class ObjectPropertiesPlayer extends ObjectProperties {

}

class ObjectPropertiesEntity extends ObjectProperties {
    
}
