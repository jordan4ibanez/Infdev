package engine;

abstract class InvRef {
	@:native("is_empty")
	public abstract function isEmpty(listName: String): Boolean;

	@:native("get_size")
	public abstract function getSize(listName: String): Int;
