package src.engine.entity.definition;

class PlayerFlags {
	public var breathing: Bool;
	public var drowning: Bool;
	@:native("node_damage")
	public var nodeDamage: Bool;

	public function new() {}

	public inline function setBreathing(breathing: Bool): PlayerFlags {
		this.breathing = breathing;
		return this;
	}

	public inline function setDrowning(drowning: Bool): PlayerFlags {
		this.drowning = drowning;
		return this;
	}

	public inline function set(nodeDamage: Bool): PlayerFlags {
		this.nodeDamage = nodeDamage;
		return this;
	}
}
