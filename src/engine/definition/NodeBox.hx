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
	var fixed: BoxArray = [];

	public function new() {
		super(NodeBoxTypeFixed);
	}

	public function addBox(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxFixed {
		this.fixed.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}
}

class NodeBoxLeveled extends NodeBox {
	var fixed: BoxArray = [];

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
	var wallTop: Box;

	@:native("wall_bottom")
	var wallBottom: Box;

	@:native("wall_side")
	var wallSide: Box;

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

	    fixed = box OR {box1, box2, ...}
    connect_top = box OR {box1, box2, ...}
    connect_bottom = box OR {box1, box2, ...}
    connect_front = box OR {box1, box2, ...}
    connect_left = box OR {box1, box2, ...}
    connect_back = box OR {box1, box2, ...}
    connect_right = box OR {box1, box2, ...}
    -- The following `disconnected_*` boxes are the opposites of the
    -- `connect_*` ones above, i.e. when a node has no suitable neighbor
    -- on the respective side, the corresponding disconnected box is drawn.
    disconnected_top = box OR {box1, box2, ...}
    disconnected_bottom = box OR {box1, box2, ...}
    disconnected_front = box OR {box1, box2, ...}
    disconnected_left = box OR {box1, box2, ...}
    disconnected_back = box OR {box1, box2, ...}
    disconnected_right = box OR {box1, box2, ...}
    disconnected = box OR {box1, box2, ...} -- when there is *no* neighbor
    disconnected_sides = box OR {box1, box2, ...} -- when there are *no*

	public function new() {
		super(NodeBoxTypeConnected);
	}
}
