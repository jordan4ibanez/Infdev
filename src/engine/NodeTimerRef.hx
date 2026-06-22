package engine;

abstract class NodeTimerRef {
	abstract public function set(timeout: Float, elapsed: Float): Void;

	abstract public function start(timeout: Float): Void;

	abstract public function stop(): Void;

	@:native("get_timeout")
	abstract public function getTimeout(): Float;

	@:native("get_elapsed")
	abstract public function getElapsed(): Float;

	@:native("is_started")
	abstract public function isStarted(): Bool;
}
