package src.engine.recipe;

typedef CraftRecipeShaped = {
	var recipe: Array<Array<String>>;

	@:optional
	var replacements: Map<String, String>;

	@:optional
	var amount: Int;
}
