package src.engine;

import src.engine.vector.Vec3;

// This is basically just a read only setter.
typedef NoiseParams = {
	var offset: Float;
	var scale: Float;
	var spread: Vec3;
	var seed: Int;
	var octaves: Int;
	var persistence: Float;
	var lacunarity: Float;
	@:optional
	var flags: String;
}
