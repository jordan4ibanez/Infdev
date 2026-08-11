package src.engine;

typedef InventoryActionInfo = {
	var count: Int;
	var from_index: Int;
	var from_list: String;
	@:optional
	var to_index: Int;
	@:optional
	var to_list: String;
}
