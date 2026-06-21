package engine.definition.sound;

class NodeSoundTable {
	private var footstep: SimpleSoundSpec;//done

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
	public function set(sound: SimpleSoundSpec): NodeSoundTable {
		this. = sound;
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
	public function set(sound: SimpleSoundSpec): NodeSoundTable {
		this. = sound;
		return this;		
	}
	public function set(sound: SimpleSoundSpec): NodeSoundTable {
		this. = sound;
		return this;		
	}
}
