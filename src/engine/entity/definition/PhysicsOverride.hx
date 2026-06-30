package src.engine.entity.definition;

final class PhysicsOverride {
    public var speed: Float;
    @:native("speed_walk")
    public var speed_walk;
    @:native("speed_climb")
    public var speed_climb;
    @:native("speed_crouch")
    public var speed_crouch;
    @:native("speed_fast")
    public var speed_fast;
    public var jump;
    public var gravity;
    @:native("liquid_fluidity")
    public var liquid_fluidity;
    @:native("liquid_fluidity_smooth")
    public var liquid_fluidity_smooth;
    @:native("liquid_sink")
    public var liquid_sink;
    @:native("acceleration_default")
    public var acceleration_default;
    @:native("acceleration_air")
    public var acceleration_air;
    @:native("acceleration_fast")
    public var acceleration_fast;
    public var sneak;
    @:native("sneak_glitch")
    public var sneak_glitch;
    @:native("new_move")
    public var new_move;
}