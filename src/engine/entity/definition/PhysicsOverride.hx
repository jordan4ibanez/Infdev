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
    public var liquidSink;
    @:native("acceleration_default")
    public var accelerationDefault;
    @:native("acceleration_air")
    public var accelerationAir;
    @:native("acceleration_fast")
    public var accelerationFast;
    public var sneak;
    @:native("sneak_glitch")
    public var sneakGlitch;
    @:native("new_move")
    public var newMove;
}