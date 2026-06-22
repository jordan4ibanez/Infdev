package engine;

// {name="ignore", param1=0, param2=0}
class MapNode {
	private var name: String;
	private var param1: Int;
	private var param2: Int;

	public function new(name: String) {
		this.name = name;
	}

	public inline function setName(newName: String) {
		this.name = newName;
	}
}

class Blah {
	static function __init__() {
		trace("blah");

		var i = new MapNode("testing");
	}
}
