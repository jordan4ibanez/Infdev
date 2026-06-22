package engine;

// todo: getters
// https://github.com/luanti-org/luanti/blob/master/doc/lua_api.md#itemstack
extern class ItemStack {
	@:native("set_count")
	public function setCount(count: Int): Void;

	@:native("get_count")
	public function getCount(): Int;

	@:native("set_wear")
	public function setWear(wear: Int): Void;

	public function setMetadata(metadata: String): Void;
}
