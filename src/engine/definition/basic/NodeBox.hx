package src.engine.definition.basic;

import src.engine.compilercode.LuaArray;

private enum abstract NodeBoxType(String) to String {
	var NodeBoxTypeRegular = "regular";
	var NodeBoxTypeFixed = "fixed";
	var NodeBoxTypeLeveled = "leveled";
	var NodeBoxTypeWallMounted = "wallmounted";
	var NodeBoxTypeConnected = "connected";
}

typedef Box = LuaArray<Float>;
typedef BoxArray = LuaArray<Box>;

abstract class NodeBox {
	public var type: NodeBoxType;

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
	public var fixed: BoxArray = [];

	public function new() {
		super(NodeBoxTypeFixed);
	}

	public function addBox(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxFixed {
		this.fixed.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}
}

class NodeBoxLeveled extends NodeBox {
	public var fixed: BoxArray = [];

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
	public var wallTop: Box;

	@:native("wall_bottom")
	public var wallBottom: Box;

	@:native("wall_side")
	public var wallSide: Box;

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
	public var fixed: BoxArray;

	// Connected.
	@:native("connect_top")
	public var connectTop: BoxArray;
	@:native("connect_bottom")
	public var connectBottom: BoxArray;
	@:native("connect_front")
	public var connectFront: BoxArray;
	@:native("connect_left")
	public var connectLeft: BoxArray;
	@:native("connect_back")
	public var connectBack: BoxArray;
	@:native("connect_right")
	public var connectRight: BoxArray;

	// Disconnected.
	@:native("disconnected_top")
	public var disconnectedTop: BoxArray;
	@:native("disconnected_bottom")
	public var disconnectedBottom: BoxArray;
	@:native("disconnected_front")
	public var disconnectedFront: BoxArray;
	@:native("disconnected_left")
	public var disconnectedLeft: BoxArray;
	@:native("disconnected_back")
	public var disconnectedBack: BoxArray;
	@:native("disconnected_right")
	public var disconnectedRight: BoxArray;

	public var disconnected: BoxArray;
	@:native("disconnected_sides")
	public var disconnectedSides: BoxArray;

	public function new() {
		super(NodeBoxTypeConnected);
	}

	public function setFixed(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.fixed == null) {
			this.fixed = [];
		}
		this.fixed.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setConnectTop(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.connectTop == null) {
			this.connectTop = [];
		}
		this.connectTop.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setConnectBottom(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.connectBottom == null) {
			this.connectBottom = [];
		}
		this.connectBottom.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setConnectFront(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.connectFront == null) {
			this.connectFront = [];
		}
		this.connectFront.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setConnectLeft(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.connectLeft == null) {
			this.connectLeft = [];
		}
		this.connectLeft.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setConnectBack(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.connectBack == null) {
			this.connectBack = [];
		}
		this.connectBack.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setConnectRight(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.connectRight == null) {
			this.connectRight = [];
		}
		this.connectRight.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setDisconnectedTop(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.disconnectedTop == null) {
			this.disconnectedTop = [];
		}
		this.disconnectedTop.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setDisconnectedBottom(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.disconnectedBottom == null) {
			this.disconnectedBottom = [];
		}
		this.disconnectedBottom.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setDisconnectedFront(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.disconnectedFront == null) {
			this.disconnectedFront = [];
		}
		this.disconnectedFront.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setDisconnectedLeft(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.disconnectedLeft == null) {
			this.disconnectedLeft = [];
		}
		this.disconnectedLeft.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setDisconnectedBack(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.disconnectedBack == null) {
			this.disconnectedBack = [];
		}
		this.disconnectedBack.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setDisconnectedRight(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.disconnectedRight == null) {
			this.disconnectedRight = [];
		}
		this.disconnectedRight.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setDisconnected(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.disconnected == null) {
			this.disconnected = [];
		}
		this.disconnected.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}

	public function setDisconnectedSides(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): NodeBoxConnected {
		if (this.disconnectedSides == null) {
			this.disconnectedSides = [];
		}
		this.disconnectedSides.push([x1, y1, z1, x2, y2, z2]);
		return this;
	}
}

// class Blah {
// 	static function __init__() {
// 		var i = new NodeBoxFixed();
// 		i.addBox(1, 2, 3, 4, 5, 6);
// 		i.addBox(1.0, 21.312, 1.123, 0.1, 0.11212, 94.0);
// 		untyped __lua__("print(dump(i))");
// 	}
// }
