package node;

import vector.EngineVector3;
import luantitypes.Macros;

@:autoBuild(luantitypes.NodeDuctTape.build())
@:build(luantitypes.NodeDuctTape.build())
abstract class Node {
	// static function __init__() {
	// 	var t: NodeDef = Dirt;
	// }
	// public static function on_construct(pos: EngineVector3) {};
	public function testing(): Void {};
}

@:registerNode("")
class Dirt extends Node {}
