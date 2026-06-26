package src.engine;

import src.engine.vector.EngineVector3;

@:final
abstract class VoxelArea {
	static inline function create(minPos: EngineVector3, maxPos: EngineVector3): VoxelArea {
		return untyped __lua__("VoxelArea(minPos, maxPos)");
	}
}
