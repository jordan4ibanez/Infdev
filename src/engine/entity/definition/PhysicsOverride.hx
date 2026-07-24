package src.engine.entity.definition;

// This class was almost AI generated but that felt boring.
// So, I wrote it by hand.
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

	// public function new() {}

	// public inline function setSpeed(speed: Float): PhysicsOverride {
	// 	this.speed = speed;
	// 	return this;
	// }

	// public inline function setSpeedWalk(speedWalk: Float): PhysicsOverride {
	// 	this.speedWalk = speedWalk;
	// 	return this;
	// }

	// public inline function setSpeedClimb(speedClimb: Float): PhysicsOverride {
	// 	this.speedClimb = speedClimb;
	// 	return this;
	// }

	// public inline function setSpeedCrouch(speedCrouch: Float): PhysicsOverride {
	// 	this.speedCrouch = speedCrouch;
	// 	return this;
	// }

	// public inline function setSpeedFast(speedFast: Float): PhysicsOverride {
	// 	this.speedFast = speedFast;
	// 	return this;
	// }

	// public inline function setJump(jump: Float): PhysicsOverride {
	// 	this.jump = jump;
	// 	return this;
	// }

	// public inline function setGravity(gravity: Float): PhysicsOverride {
	// 	this.gravity = gravity;
	// 	return this;
	// }

	// public inline function setLiquidFluidity(liquidFluidity: Float): PhysicsOverride {
	// 	this.liquidFluidity = liquidFluidity;
	// 	return this;
	// }

	// public inline function setLiquidFluiditySmooth(liquidFluiditySmooth: Float): PhysicsOverride {
	// 	this.liquidFluiditySmooth = liquidFluiditySmooth;
	// 	return this;
	// }

	// public inline function setLiquidSink(liquidSink: Float): PhysicsOverride {
	// 	this.liquidSink = liquidSink;
	// 	return this;
	// }

	// public inline function setAccelerationDefault(accelerationDefault: Float): PhysicsOverride {
	// 	this.accelerationDefault = accelerationDefault;
	// 	return this;
	// }

	// public inline function setAccelerationAir(accelerationAir: Float): PhysicsOverride {
	// 	this.accelerationAir = accelerationAir;
	// 	return this;
	// }

	// public inline function setAccelerationFast(accelerationFast: Float): PhysicsOverride {
	// 	this.accelerationFast = accelerationFast;
	// 	return this;
	// }

	// public inline function setSneak(sneak: Bool): PhysicsOverride {
	// 	this.sneak = sneak;
	// 	return this;
	// }

	// public inline function setSneakGlitch(sneakGlitch: Bool): PhysicsOverride {
	// 	this.sneakGlitch = sneakGlitch;
	// 	return this;
	// }

	// public inline function setNewMove(newMove: Bool): PhysicsOverride {
	// 	this.newMove = newMove;
	// 	return this;
	// }
}
