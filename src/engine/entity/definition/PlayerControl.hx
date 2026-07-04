package src.engine.entity.definition;

@:final
abstract extern class PlayerControl {
	public var up: Bool;
	public var down: Bool;
	public var left: Bool;
	public var right: Bool;
	public var jump: Bool;
	public var aux1: Bool;
	public var sneak: Bool;
	public var dig: Bool;
	public var place: Bool;
	public var LMB: Bool;
	public var RMB: Bool;
	public var zoom: Bool;

	@:native("movement_x")
	public var movementX: Float;
	@:native("movement_y")
	public var movementY: Float;
}
