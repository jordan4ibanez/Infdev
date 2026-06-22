package engine.definition.basic;

// Design goal: functional oop and make it look like lisp
class NodeDropTable {
	@:native("max_items")
	private var maxItems: Int = 1;

	public function new() {}

	public function setMaxItems(maxItems: Int): NodeDropTable {
		this.maxItems = maxItems;
		return this;
	}
}
