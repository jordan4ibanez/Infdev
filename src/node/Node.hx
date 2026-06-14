package node;

import vector.EngineVector3;
import luantitypes.Macros;

/**
 * When you extend this class, you get a specialty static class which only uses
 * OOP for auto complete.
 */
@:autoBuild(luantitypes.NodeDuctTape.build())
@:build(luantitypes.NodeDuctTape.build())
abstract class Node {
	// static function __init__() {
	// 	var t: NodeDef = Dirt;
	// }
	// public static function on_construct(pos: EngineVector3) {};
	public function testing(): Void {};
}

@:registerNode("infdev:dirt")
class Dirt extends Node {
	override function testing() {
		super.testing();
	}
}
