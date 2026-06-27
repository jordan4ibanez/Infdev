package src.engine;

import src.engine.vector.EngineVector3;

// This is basically just a read only setter.
final class NoiseParams {
	var offset: Float;
	var scale: Float;
	var spread: EngineVector3;
	var seed: Int;
	var octaves: Int;
	var persistence: Float;
	var lacunarity: Float;
	var flags: String;

	public function new() {}

	public function setOffset(offset: Float): NoiseParams {
		this.offset = offset;
		return this;
	}

	public function setScale(scale: Float): NoiseParams {
		this.scale = scale;
		return this;
	}

	public function setSpread(spread: EngineVector3): NoiseParams {
		this.spread = spread;
		return this;
	}

	public function setSeed(seed: Int): NoiseParams {
		this.seed = seed;
		return this;
	}

	public function setOctaves(octaves: Int): NoiseParams {
		this.octaves = octaves;
		return this;
	}

	public function setPersistence(persistence: Float): NoiseParams {
		this.persistence = persistence;
		return this;
	}

	public function setLacunarity(lacunarity: Float): NoiseParams {
		this.lacunarity = lacunarity;
		return this;
	}

	public function setFlags(flags: String): NoiseParams {
		this.flags = flags;
		return this;
	}
}
