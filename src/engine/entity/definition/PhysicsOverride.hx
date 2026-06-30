package src.engine.entity.definition;

final class PhysicsOverride {
	public var speed: Float;
	@:native("speed_walk")
	public var speedWalk: Float;
	@:native("speed_climb")
	public var speedClimb: Float;
	@:native("speed_crouch")
	public var speedCrouch: Float;
	@:native("speed_fast")
	public var speedFast: Float;
	public var jump: Float;
	public var gravity: Float;
	@:native("liquid_fluidity")
	public var liquidFluidity: Float;
	@:native("liquid_fluidity_smooth")
	public var liquidFluiditySmooth: Float;
	@:native("liquid_sink")
	public var liquidSink: Float;
	@:native("acceleration_default")
	public var accelerationDefault: Float;
	@:native("acceleration_air")
	public var accelerationAir: Float;
	@:native("acceleration_fast")
	public var accelerationFast: Float;
	public var sneak: Bool;
	@:native("sneak_glitch")
	public var sneakGlitch: Bool;
	@:native("new_move")
	public var newMove: Bool;

	public function new() {}
}
