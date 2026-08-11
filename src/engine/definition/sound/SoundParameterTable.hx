package src.engine.definition.sound;

import src.engine.entity.objectref.ObjectRefBase;
import src.engine.vector.Vec3;

class SoundParameterTable {
	var gain = 1.0;

	// Scales the gain specified in `SimpleSoundSpec`.
	var pitch = 1.0;

	// Overwrites the pitch specified in `SimpleSoundSpec`.
	var fade = 0.0;

	// Overwrites the fade specified in `SimpleSoundSpec`.
	var start_time = 0.0;

	// Start with a time-offset into the sound.
	// The behavior is as if the sound was already playing for this many seconds.
	// Negative values are relative to the sound's length, so the sound reaches
	// its end in `-start_time` seconds.
	// It is unspecified what happens if `loop` is false and `start_time` is
	// smaller than minus the sound's length.
	// Available since feature `sound_params_start_time`.
	var loop = false;

	// If true, sound is played in a loop.
	var pos: Vec3;

	// Play sound at a position.
	// Can't be used together with `object`.
	var object: ObjectRefBase;

	// Attach the sound to an object.
	// Can't be used together with `pos`.
	var to_player: String;

	// Only play for this player.
	// Can't be used together with `exclude_player`.
	var exclude_player: String;

	// Don't play sound for this player.
	// Can't be used together with `to_player`.
	var max_hear_distance: String;
	// Only play for players that are at most this far away when the sound
	// starts playing.
	// Needs `pos` or `object` to be set.
	// `32` is the default.
}
