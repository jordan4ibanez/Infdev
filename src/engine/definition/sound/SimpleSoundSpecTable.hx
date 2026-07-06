package src.engine.definition.sound;

class SimpleSoundSpecTable {
	var name: String;
	var gain: Float = 1.0;
	var pitch: Float = 1.0;
	var fade: Float = 0.0;

	public function new(name: String = "") {
		this.name = name;
	}

	// Uses builder pattern.

	public function setGain(gain: Float): SimpleSoundSpecTable {
		this.gain = gain;
		return this;
	}

	public function setPitch(pitch: Float): SimpleSoundSpecTable {
		this.pitch = pitch;
		return this;
	}

	public function setFade(fade: Float): SimpleSoundSpecTable {
		this.fade = fade;
		return this;
	}
}
