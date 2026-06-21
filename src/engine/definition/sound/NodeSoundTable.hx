package engine.definition.sound;

class NodeSoundTable {
	private var footstep: SimpleSoundSpec;//done

	private var dig: SimpleSoundSpec;//done

	private var dug: SimpleSoundSpec;//done

	private var place: SimpleSoundSpec;//done

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
	public function set(sound: SimpleSoundSpec): NodeSoundTable {
		this. = sound;
		return this;		
	}
	public function set(sound: SimpleSoundSpec): NodeSoundTable {
		this. = sound;
		return this;		
	}
}
