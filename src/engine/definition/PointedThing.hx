package engine.definition;

import engine.entity.objectref.ObjectRefBase;
import engine.vector.EngineVector3;

enum abstract PointedThingType(String) to String {
	var object;
	var nothing;
	var PointedThingTypeNode = "node";
}

abstract class PointedThing {
	public final type: PointedThingType;

	public inline function isNode(): Bool {
		return this.type == node;
	}

	public inline function isObject(): Bool {
		return this.type == object;
	}

	public inline function isNothing(): Bool {
		return this.type == nothing;
	}

	public inline function whenIsNode(delegate: (PointedThingNode) -> Void): Void {
		if (this.isNode()) {
			delegate(cast(this));
		}
	}

	public inline function whenIsObject(delegate: (PointedThingObject) -> Void): Void {
		if (this.isObject()) {
			delegate(cast(this));
		}
	}

	public inline function whenIsNothing(delegate: (PointedThingNothing) -> Void): Void {
		if (this.isNothing()) {
			delegate(cast(this));
		}
	}

	public inline function match(nodeDelegate: Null<(PointedThingNode) -> Void>, objectDelegate: Null<(PointedThingObject) -> Void>,
			nothingDelegate: Null<(PointedThingNothing) -> Void>): Void {
		switch (this.type) {
			case node:
				if (nodeDelegate != null) {
					nodeDelegate(cast(this));
				}
			case object:
				if (objectDelegate != null) {
					objectDelegate(cast(this));
				}
			case nothing:
				if (nothingDelegate != null) {
					nothingDelegate(cast(this));
				}
		}
	}
}

final class PointedThingNode extends PointedThing {
	var under: EngineVector3;
	var above: EngineVector3;

	public function new() {
		this.type = node;
	}
}

final class PointedThingObject extends PointedThing {
	var ref: ObjectRefBase;

	public function new() {
		this.type = object;
	}
}

final class PointedThingNothing extends PointedThing {
	public function new() {
		this.type = nothing;
	}
}

/**
 * Specialty pointed thing for some reason.
 * Only supported on raycast.
 */
final class PointedThingRayCast {
	@:native("intersection_point")
	var intersectionPoint: EngineVector3;

	@:native("box_id")
	var boxID: Int;

	@:native("intersection_normal")
	var intersectionNormal: EngineVector3;
}

// class Blah {
// 	static function __init__() {
// 		var i = new PointedThingNothing();
// 		var w = cast(i, PointedThing);
// 		var a = w.isNode();
// 		var b = w.isObject();
// 		var c = w.isNothing();
// 		w.match(
// 			(node) -> {},
// 			(object) -> {},
// 			(nothing) -> {}
// 		);
// 		Lua.print("marker", a, b, c);
// 	}
// }
