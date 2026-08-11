package src.engine.definition.sound;

import src.engine.entity.objectref.ObjectRefBase;
import src.engine.vector.Vec3;

class SoundParameterTable {
	var gain: Float;
	var pitch: Float;
	var fade: Float;
	var start_time: Float;
	var loop = false;
	var pos: Vec3;
	var object: ObjectRefBase;
	var to_player: String;
	var exclude_player: String;
	var max_hear_distance: String;
}
