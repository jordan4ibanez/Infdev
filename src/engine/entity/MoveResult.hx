package src.engine.entity;

import src.engine.compilercode.LuaArray;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.vector.Vec3;

typedef CollisionInfo = {
	var type: String; // "node" or "object",
	var axis: String; // "x", "y" or "z"
	var node_pos: Vec3; // if type is "node"
	var object: ObjectRefBase; // if type is "object"
	// The position of the entity when the collision occurred.
	// Available since feature "moveresult_new_pos".
	var new_pos: Vec3;
	var old_velocity: Vec3;
	var new_velocity: Vec3;
}

typedef MoveResult = {
	var touching_ground: Bool;

	// Note that touching_ground is only true if the entity was moving and
	// collided with ground.
	var collides: Bool;
	var standing_on_object: Bool;

	var collisions: LuaArray<CollisionInfo>;
	// `collisions` does not contain data of unloaded mapblock collisions
	// or when the velocity changes are negligibly small
}
