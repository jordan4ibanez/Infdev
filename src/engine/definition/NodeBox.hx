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
	private var fixed: BoxArray; // DONE
	@:native("connect_top")
	private var connectTop: BoxArray; // done
	@:native("connect_bottom")
	private var connectBottom: BoxArray; // done
	@:native("connect_front")
	private var connectFront: BoxArray; // done
	@:native("connect_left")
	private var connectLeft: BoxArray; // done
	@:native("connect_back")
	private var connectBack: BoxArray; // done
	@:native("connect_right")
	private var connectRight: BoxArray; // done

	// Disconnected.
	@:native("disconnected_top")
	private var disconnectedTop: BoxArray; // done
	@:native("disconnected_bottom")
	private var disconnectedBottom: BoxArray; // done
	@:native("disconnected_front")
	private var disconnectedFront: BoxArray;
	@:native("disconnected_left")
	private var disconnectedLeft: BoxArray;
	@:native("disconnected_back")
	private var disconnectedBack: BoxArray;
	@:native("disconnected_right")
	private var disconnectedRight: BoxArray;

	private var disconnected: BoxArray;
	@:native("disconnected_sides")
	private var disconnectedSides: BoxArray;

	public function new() {
		super(NodeBoxTypeConnected);
	}

	public function setFixed(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.fixed == null) {
			this.fixed = []
		}
		this.fixed.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setConnectTop(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.connectTop == null) {
			this.connectTop = []
		}
		this.connectTop.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setConnectBottom(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.connectBottom == null) {
			this.connectBottom = []
		}
		this.connectBottom.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setConnectFront(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.connectFront == null) {
			this.connectFront = []
		}
		this.connectFront.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setConnectLeft(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.connectLeft == null) {
			this.connectLeft = []
		}
		this.connectLeft.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setConnectBack(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.connectBack == null) {
			this.connectBack = []
		}
		this.connectBack.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setConnectRight(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.connectRight == null) {
			this.connectRight = []
		}
		this.connectRight.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setDisconnectedTop(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.disconnectedTop == null) {
			this.disconnectedTop = []
		}
		this.disconnectedTop.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setDisconnectedBottom(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.disconnectedBottom == null) {
			this.disconnectedBottom = []
		}
		this.disconnectedBottom.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setDisconnected(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this. == null) {
			this. = []
		}
		this..push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setDisconnected(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this. == null) {
			this. = []
		}
		this..push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setDisconnected(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this. == null) {
			this. = []
		}
		this..push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setDisconnected(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this. == null) {
			this. = []
		}
		this..push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setDisconnected(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this. == null) {
			this. = []
		}
		this..push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setDisconnected(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this. == null) {
			this. = []
		}
		this..push([x1, y1, z1, x2, y2, z2]);
		return this;
	}
}
