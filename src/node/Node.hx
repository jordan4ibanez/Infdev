package node;

typedef NodeDef = {
	@:native("on_step")
	function onStep(): Void;
}

@:autoBuild(luantitypes.NodeDuctTape.build())
@:build(luantitypes.NodeDuctTape.build())
abstract class Node {
	// static function __init__() {
	// 	var t: NodeDef = Dirt;
	// }
}

@:registerNode("")
class Dirt extends Node {
	public static function onStep() {};
}
