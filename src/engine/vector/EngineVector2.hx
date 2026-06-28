package src.engine.vector;

/**
 * This class technically doesn't exist.
 */
abstract class EngineVector2 {
	public var x: Float = 0;
	public var y: Float = 0;

	public static function toVec2(self: EngineVector2): Vec2 {
		return new Vec2(self.x, self.y);
	}
}
