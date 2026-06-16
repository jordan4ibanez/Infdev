package definition.sound;

class ItemSoundTable {
	var breaks: SimpleSoundSpec;
	var eat: SimpleSoundSpec;
	@:native("punch_use")
	var punchUse: SimpleSoundSpec;
	@:native("punch_use_air")
	var punchUseAir: SimpleSoundSpec;

	public function new() {}

	// Uses builder pattern.

	public function setBreaks(breaks: SimpleSoundSpec): ItemSoundTable {
		this.breaks = breaks;
		return this;
	}

	public function setEat(eat: SimpleSoundSpec): ItemSoundTable {
		this.eat = eat;
		return this;
	}

	public function setPunchUse(punchUse: SimpleSoundSpec): ItemSoundTable {
		this.punchUse = punchUse;
		return this;
	}

	public function setPunchUseAir(punchUseAir: SimpleSoundSpec): ItemSoundTable {
		this.punchUseAir = punchUseAir;
		return this;
	}
}
