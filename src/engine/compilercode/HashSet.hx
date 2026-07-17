package src.engine.compilercode;

import haxe.Rest;

// I tried to AI generate this but the AI exploded trying to figure it out.
abstract HashSet<T:{}>(Map<T, Bool>) {
	public inline function new() {
		this = new Map();
	}

	public inline function contains(thing: T): Bool {
		return this.exists(thing);
	}

	public inline function insert(thing: T, otherThings: Rest<T>): Void {
		this.set(thing, true);
		for (t in otherThings) {
			this.set(t, true);
		}
	}

	public inline function length(): Int {
		var count = 0;
		for (_ in this.keys()) {
			count++;
		}
		return count;
	}

	public inline function remove(thing: T, otherThings: Rest<T>): Void {
		this.remove(thing);
		for (t in otherThings) {
			this.remove(t);
		}
	}
}
// class Blah {
// 	static function __init__() {
// 		trace("BEGIN TEST OF HASHSET");
// 		var x = new HashSet<String>();
// 		x.insert("test");
// 		x.insert("other stuff", "cool", "blah");
// 		trace(x.contains("test"));
// 		trace(x.length());
// 		x.remove("test");
// 		trace(x.length());
// 		trace(x.contains("test"));
// 		x.remove("other stuff", "cool", "doesn't exist");
// 		trace(x.length());
// 	}
// }
