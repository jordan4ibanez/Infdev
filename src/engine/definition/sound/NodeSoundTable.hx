package engine.definition.sound;

class NodeSoundTable {
	private var footstep: SimpleSoundSpec;

	private var dig: SimpleSoundSpec;

	private var dug: SimpleSoundSpec;

	private var place: SimpleSoundSpec;

	@:native("place_failed")
	private var placeFailed: SimpleSoundSpec;

	private var fall: SimpleSoundSpec;
}
