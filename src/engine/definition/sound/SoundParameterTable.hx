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
	var max_hear_distance: Float;

	public function new() {}

	public function setGain(gain: Float): SoundParameterTable {
		this.gain = gain;
		return this;
	}

	public function setPitch(pitch: Float): SoundParameterTable {
		this.pitch = pitch;
		return this;
	}

	public function setFade(fade: Float): SoundParameterTable {
		this.fade = fade;
		return this;
	}

	public function setStartTime(startTime: Float): SoundParameterTable {
		this.start_time = startTime;
		return this;
	}

	public function setLoop(loop: Bool): SoundParameterTable {
		this.loop = loop;
		return this;
	}

	public function setPos(pos: Vec3): SoundParameterTable {
		this.pos = pos;
		return this;
	}

	public function setObject(object: ObjectRefBase): SoundParameterTable {
		this.object = object;
		return this;
	}

	public function setToPlayer(playerName: String): SoundParameterTable {
		this.to_player = playerName;
		return this;
	}

	public function setExcludePlayer(playerName: String): SoundParameterTable {
		this.exclude_player = playerName;
		return this;
	}

	public function setMaxHearDistance(maxHearDistance: Float): SoundParameterTable {
		this.max_hear_distance = maxHearDistance;
		return this;
	}
}
