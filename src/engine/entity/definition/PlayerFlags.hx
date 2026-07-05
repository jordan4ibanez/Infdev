package src.engine.entity.definition;

class PlayerFlags {
    public var breathing: Bool;
    public var drowning: Bool;
    @:native("node_damage")
    public var nodeDamage: Bool;
}