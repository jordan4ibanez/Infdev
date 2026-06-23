package engine;

abstract class InvRef {
	@:native("is_empty")
	public abstract function isEmpty(listName: String): Boolean;

	@:native("get_size")
	public abstract function getSize(listName: String): Int;

	@:native("set_size")
	public abstract function setSize(listName: String, size: Int): Null<Bool>;

	@:native("get_width")
	public abstract function getWidth(listName: String): Int;
