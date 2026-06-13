package node;

typedef NodeDef = {
	@:native("on_step")
	function onStep(): Void;
}

abstract class Node {
	// static function __init__() {
	// 	var t: NodeDef = Dirt;
	// }
}

class Dirt extends Node {
	public static function onStep() {};
}
