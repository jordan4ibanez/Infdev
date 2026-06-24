package src.engine;

abstract class NodeTimerRef {
	public abstract function set(timeout: Float, elapsed: Float): Void;

	public abstract function start(timeout: Float): Void;

	public abstract function stop(): Void;

	@:native("get_timeout")
	public abstract function getTimeout(): Float;

	@:native("get_elapsed")
	public abstract function getElapsed(): Float;

	@:native("is_started")
	public abstract function isStarted(): Bool;
}
