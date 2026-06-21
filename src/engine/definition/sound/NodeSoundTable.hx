package engine.definition.sound;

class NodeSoundTable {
	private var footstep: SimpleSoundSpec; // done

	private var dig: SimpleSoundSpec; // done

	private var dug: SimpleSoundSpec; // done

	private var place: SimpleSoundSpec; // done

	@:native("place_failed")
	private var placeFailed: SimpleSoundSpec; // done

	private var fall: SimpleSoundSpec; // done

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
