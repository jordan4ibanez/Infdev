package definition.sound;

class NodeSoundTable {
	var breaks: SimpleSoundSpec;
	var eat: SimpleSoundSpec;
	@:native("punch_use")
	var punchUse: SimpleSoundSpec;
	@:native("punch_use_air")
	var punchUseAir: SimpleSoundSpec;

	public function new() {}

	// Uses builder pattern.

	public function setBreaks(breaks: SimpleSoundSpec): NodeSoundTable {
		this.breaks = breaks;
		return this;
	}

	public function setEat(eat: SimpleSoundSpec): NodeSoundTable {
		this.eat = eat;
		return this;
	}

	public function setPunchUse(punchUse: SimpleSoundSpec): NodeSoundTable {
		this.punchUse = punchUse;
		return this;
	}

	public function setPunchUseAir(punchUseAir: SimpleSoundSpec): NodeSoundTable {
		this.punchUseAir = punchUseAir;
		return this;
	}
}
