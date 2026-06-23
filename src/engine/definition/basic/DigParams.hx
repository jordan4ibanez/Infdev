package engine.definition.basic;

// This has no definition in the docs.
// { time : 1, diggable : true, wear : 0 }
@:final
abstract class DigParams {
	private var time: Int;
	private var diggable: Bool;
	private var wear: Int;

	private function new() {}

	public inline function getTime(): Int {
		return this.time;
	}

	public inline function isDiggable(): Bool {
		return this.diggable;
	}

	public inline function getWear(): Int {
		return this.wear;
	}
}
