package src.engine.entity.definition;

typedef Animation = {
	@:native("min_frame")
	@:optional
	var minFrame: Float;

	@:native("max_frame")
	@:optional
	var maxFrame: Float;

	@:native("start_frame")
	@:optional
	var startFrame: Float;

	@:optional
	var speed: Float;

	@:optional
	var loop: Bool;

	@:optional
	var blend: Float;

	@:optional
	var priority: Int;
}
