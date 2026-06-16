package definition.sound;

class SimpleSoundSpec {
	public var name: String = "";
	public var gain: Float = 1.0;
	public var pitch: Float = 1.0;
	public var fade: Float = 0.0;

	public function new() {}

	// Uses builder pattern.

	public function setName(name: String): SimpleSoundSpec {
		this.name = name;
		return this;
	}

	public function setGain(gain: Float): SimpleSoundSpec {
		this.gain = gain;
		return this;
	}

	public function setPitch(pitch: Float): SimpleSoundSpec {
		this.pitch = pitch;
		return this;
	}

	public function setFade(fade: Float): SimpleSoundSpec {
		this.fade = fade;
		return this;
	}
}
