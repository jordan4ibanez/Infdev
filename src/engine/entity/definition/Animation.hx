package src.engine.entity.definition;

typedef Animation = {
	@:optional
	var min_frame: Float;

	@:optional
	var max_frame: Float;

	@:optional
	var start_frame: Float;

	@:optional
	var speed: Float;

	@:optional
	var loop: Bool;

	@:optional
	var blend: Float;

	@:optional
	var priority: Int;
}

typedef AnimationUpdate = {
	@:optional
	var speed: Float;
}
