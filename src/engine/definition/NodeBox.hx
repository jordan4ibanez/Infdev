package engine.definition;

private enum abstract NodeBoxType(String) to String {
	var NodeBoxTypeRegular = "regular";
	var NodeBoxTypeFixed = "fixed";
	var NodeBoxTypeLeveled = "leveled";
	var NodeBoxTypeWallMounted = "wallmounted";
	var NodeBoxTypeConnected = "connected";
}

typedef Box = Array<Float>;
typedef BoxArray = Array<Box>;

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

class NodeBoxFixed extends NodeBox {
	private var fixed: BoxArray = [];

	public function new() {
		super(NodeBoxTypeFixed);
	}

	public function addBox(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxFixed {
		this.fixed.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}
}

class NodeBoxLeveled extends NodeBox {
	private var fixed: BoxArray = [];

	public function new() {
		super(NodeBoxTypeLeveled);
	}

	public function addBox(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxLeveled {
		this.fixed.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}
}

class NodeBoxWallMounted extends NodeBox {
	@:native("wall_top")
	private var wallTop: Box;

	@:native("wall_bottom")
	private var wallBottom: Box;

	@:native("wall_side")
	private var wallSide: Box;

	public function new() {
		super(NodeBoxTypeWallMounted);
	}

	public function setWallTop(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxWallMounted {
		this.wallTop = [x1, y1, z1, x2, y2, z2];
		return this;
	}

	public function setWallBottom(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxWallMounted {
		this.wallBottom = [x1, y1, z1, x2, y2, z2];
		return this;
	}

	public function setWallSide(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxWallMounted {
		this.wallSide = [x1, y1, z1, x2, y2, z2];
		return this;
	}
}

class NodeBoxConnected extends NodeBox {
	// Connected.
	private var fixed: BoxArray;
	private var connect_top: BoxArray;
	private var connect_bottom: BoxArray;
	private var connect_front: BoxArray;
	private var connect_left: BoxArray;
	private var connect_back: BoxArray;
	private var connect_right: BoxArray;

	// Disconnected.
	private var disconnected_top: BoxArray;
	private var disconnected_bottom: BoxArray;
	private var disconnected_front: BoxArray;
	private var disconnected_left: BoxArray;
	private var disconnected_back: BoxArray;
	private var disconnected_right: BoxArray;
	private var disconnected: BoxArray;
	private var disconnected_sides: BoxArray;

	public function new() {
		super(NodeBoxTypeConnected);
	}
}
