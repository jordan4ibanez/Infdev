package definition.sound;

class NodeSoundTable {
	public var breaks: SimpleSoundSpec;
	public var eat: SimpleSoundSpec;
	@:native("punch_use")
	public var punchUse: SimpleSoundSpec;
	@:native("punch_use_air")
	public var punchUseAir: SimpleSoundSpec;

	static function __init__() {
		var x = new NodeSoundTable()
			.setBreaks(new SimpleSoundSpec("test.ogg"));
	}

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
