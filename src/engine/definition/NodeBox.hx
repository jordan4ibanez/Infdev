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
	var fixed: Array<Array<Float>> = [];

	public function new() {
		super(NodeBoxTypeRegular);
	}

	public function addBox(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxRegular {
		this.fixed.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}
}

class NodeBoxFixed extends NodeBox {
	var fixed: Array<Array<Float>> = [];

	public function new() {
		super(NodeBoxTypeFixed);
	}

	public function addBox(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxFixed {
		this.fixed.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}
}

class NodeBoxLeveled extends NodeBox {
	public function new() {
		super(NodeBoxTypeLeveled);
	}
}

class NodeBoxWallMounted extends NodeBox {
	public function new() {
		super(NodeBoxTypeWallMounted);
	}
}

class NodeBoxConnected extends NodeBox {
	public function new() {
		super(NodeBoxTypeConnected);
	}
}
