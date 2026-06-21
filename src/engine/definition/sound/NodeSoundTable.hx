package engine.definition.sound;

class NodeSoundTable {
	private var footstep: SimpleSoundSpec;

	private var dig: SimpleSoundSpec;

	private var dug: SimpleSoundSpec;

	private var place: SimpleSoundSpec;

	@:native("place_failed")
	private var placeFailed: SimpleSoundSpec;

	private var fall: SimpleSoundSpec;

	public function new() {}

	public function setFootstep(sound: SimpleSoundSpec): NodeSoundTable {
		this.footstep = sound;
		return this;
	}

	public function setDig(sound: SimpleSoundSpec): NodeSoundTable {
		this.dig = sound;
		return this;
	}

	public function setDug(sound: SimpleSoundSpec): NodeSoundTable {
		this.dug = sound;
		return this;
	}

	public function setPlace(sound: SimpleSoundSpec): NodeSoundTable {
		this.place = sound;
		return this;
	}

	public function setPlaceFailed(sound: SimpleSoundSpec): NodeSoundTable {
		this.placeFailed = sound;
		return this;
	}

	public function setFall(sound: SimpleSoundSpec): NodeSoundTable {
		this.fall = sound;
		return this;
	}
}
