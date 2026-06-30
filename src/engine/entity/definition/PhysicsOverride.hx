package src.engine.entity.definition;

final class PhysicsOverride {
    public var speed: Float;
    @:native("speed_walk")
    public var speedWalk;
    @:native("speed_climb")
    public var speedClimb;
    @:native("speed_crouch")
    public var speedCrouch;
    @:native("speed_fast")
    public var speedFast;
    public var jump;
    public var gravity;
    @:native("liquid_fluidity")
    public var liquidFluidity;
    @:native("liquid_fluidity_smooth")
    public var liquidFluiditySmooth;
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