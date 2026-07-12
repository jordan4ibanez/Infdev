package src.engine.vector;

// This is a completely virtual class.
abstract AdvancedVector3({
	var x: Float;
	var y: Float;
	var z: Float;
}) {
	public inline function new(x: Float, y: Float, z: Float) {
		this = untyped __lua__("vector.new({0}, {1}, {2})", x, y, z);
	}
}
