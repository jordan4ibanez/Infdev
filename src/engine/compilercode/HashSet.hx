package src.engine.compilercode;

// I tried to AI generate this but the AI exploded trying to figure it out.

abstract HashSet<T:{}>(Map<T, Bool>) {
	public inline function new() {
		this = new Map();
	}

	public inline function contains(thing: T): Bool {
		return this.exists(thing);
	}

	public inline function insert(thing: T): Void {
		this.set(thing, true);
	}

	public inline function length(): Int {
		var count = 0;
		for (_ in this.keys()) {
			count++;
		}
		return count;
	}

	public inline function remove(thing: T): Bool {
		return this.remove(thing);
	}
}

// class Blah {
// 	static function __init__() {
// 		trace("BEGIN TEST OF HASHSET");
// 		var x = new HashSet<String>();
// 		x.insert("test");
// 		trace(x.contains("test"));
// 		trace(x.length());
// 		x.remove("test");
// 		trace(x.length());
// 		trace(x.contains("test"));
// 	}
// }
