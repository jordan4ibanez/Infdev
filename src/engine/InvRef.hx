package engine;

abstract class InvRef {
	@:native("is_empty")
	public abstract function isEmpty(listName: String): Boolean;
