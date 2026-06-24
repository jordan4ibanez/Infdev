package src.engine.vector;

/**
 * This class technically doesn't exist.
 */
abstract class EngineVector3 {
	public var x: Float = 0;
	public var y: Float = 0;
	public var z: Float = 0;

	public static function toVec3(self: EngineVector3): Vec3 {
		return new Vec3(self.x, self.y, self.z);
	}
}
