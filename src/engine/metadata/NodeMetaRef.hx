package engine.metadata;

abstract class NodeMetaRef extends MetaDataRef {
	@:native("get_inventory")
	abstract public function getInventory(): InvRef;

	@:native("mark_as_private")
	abstract public function markAsPrivate(name: String): Void;

	// todo: rest version with a lua table as an inline.
}
