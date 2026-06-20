package engine.definition;

private enum abstract NodeBoxType(String) to String {
	var NodeBoxTypeRegular = "regular";
	var NodeBoxTypeFixed = "fixed";
	var NodeBoxTypeLeveled = "leveled";
	var NodeBoxTypeWallMounted = "wallmounted";
	var NodeBoxTypeConnected = "connected";
}

abstract class NodeBox {
	private var type: NodeBoxType;

	public function new(type: NodeBoxType) {
		this.type = type;
	}
}

class NodeBoxRegular extends NodeBox {
	public function new() {
		super(NodeBoxTypeRegular);
	}
}
