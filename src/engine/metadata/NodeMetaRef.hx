package src.engine.metadata;

abstract class NodeMetaRef extends MetaDataRef {
	@:native("get_inventory")
	public abstract function getInventory(): InvRef;

	@:native("mark_as_private")
	public abstract function markAsPrivate(name: String): Void;

	// todo: rest version with a lua table as an inline.
}
