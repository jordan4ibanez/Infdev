package engine;

// todo: getters
// todo: rework this entire thing this is just a bootstrap
// https://github.com/luanti-org/luanti/blob/master/doc/lua_api.md#itemstack
extern class ItemStack {
	@:native("set_count")
	public function setCount(count: Int): Void;

	@:native("get_count")
	public function getCount(): Int;

	@:native("get_wear")
	public function getWear(): Int;

	@:native("add_wear")
	public function addWear(wear: Int): Void;

	@:native("set_wear")
	public function setWear(wear: Int): Void;

	public function setMetadata(metadata: String): Void;
}
