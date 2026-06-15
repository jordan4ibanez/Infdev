package definition;

class ItemImageDefinition {
	var name: String;
	var animation: TileAnimationDefinition;

	public function new(name: String, animation: TileAnimationDefinition) {
		this.name = name;
		this.animation = animation;
	}
}
