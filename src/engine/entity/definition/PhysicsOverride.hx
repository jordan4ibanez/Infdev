package src.engine.entity.definition;

final class PhysicsOverride {
	public var speed: Float;//
	@:native("speed_walk")
	public var speedWalk: Float;//
	@:native("speed_climb")
	public var speedClimb: Float;//
	@:native("speed_crouch")
	public var speedCrouch: Float;//
	@:native("speed_fast")
	public var speedFast: Float;//
	public var jump: Float;//
	public var gravity: Float;//
	@:native("liquid_fluidity")
	public var liquidFluidity: Float;//
	@:native("liquid_fluidity_smooth")
	public var liquidFluiditySmooth: Float;//
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

	// todo: write setters that return this thing for builder pattern

	public function setSpeed(speed : Float): PhysicsOverride {
		this.speed= speed ;
		return this;
	}
	public function setSpeedWalk(speedWalk : Float): PhysicsOverride {
		this.speedWalk = speedWalk;
		return this;
	}
	public function setSpeedClimb(speedClimb : Float): PhysicsOverride {
		this.speedClimb =speedClimb ;
		return this;
	}
	public function setSpeedCrouch(speedCrouch : Float): PhysicsOverride {
		this.speedCrouch = speedCrouch;
		return this;
	}
	public function setSpeedFast( speedFast: Float): PhysicsOverride {
		this.speedFast = speedFast;
		return this;
	}
	public function setJump(jump : Float): PhysicsOverride {
		this.jump =  jump;
		return this;
	}
	public function setGravity(gravity : Float): PhysicsOverride {
		this.gravity =gravity ;
		return this;
	}
	public function setLiquidFluidity(liquidFluidity : Float): PhysicsOverride {
		this.liquidFluidity =  liquidFluidity;
		return this;
	}
	public function setLiquidFluiditySmooth(liquidFluiditySmooth : Float): PhysicsOverride {
		this.liquidFluiditySmooth = liquidFluiditySmooth;
		return this;
	}
	public function set( : Float): PhysicsOverride {
		this. = ;
		return this;
	}
	public function set( : Float): PhysicsOverride {
		this. = ;
		return this;
	}
	public function set( : Float): PhysicsOverride {
		this. = ;
		return this;
	}
	public function set( : Float): PhysicsOverride {
		this. = ;
		return this;
	}
}
