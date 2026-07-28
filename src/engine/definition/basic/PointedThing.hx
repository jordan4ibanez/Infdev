package src.engine.definition.basic;

import src.engine.entity.objectref.ObjectRefBase;
import src.engine.vector.Vec3;

enum abstract PointedThingType(String) to String {
	var PointedThingTypeNode = "node";
	var PointedThingTypeObject = "object";
	var PointedThingTypeNothing = "nothing";
}

typedef PointedThing = {
	final type: PointedThingType;
	var under: Vec3;
	var above: Vec3;
	var ref: ObjectRefBase;
}

/**
 * Specialty pointed thing for some reason.
 * Only supported on raycast.
 */
final class PointedThingRayCast {
	@:native("intersection_point")
	var intersectionPoint: Vec3;

	@:native("box_id")
	var boxID: Int;

	@:native("intersection_normal")
	var intersectionNormal: Vec3;
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
