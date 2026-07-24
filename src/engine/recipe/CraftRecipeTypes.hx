package src.engine.recipe;

typedef CraftRecipeShaped = {
	var recipe: Array<Array<String>>;

	// todo: needs: type = "shaped"
	@:optional
	var replacements: Map<String, String>;

	// Defaults to 1.
	@:optional
	var amount: Int;
}

typedef CraftRecipeShapeless = {
	var recipe: Array<String>;

	// todo: needs: type = "shapeless"
	@:optional
	var replacements: Map<String, String>;

	// Defaults to 1.
	@:optional
	var amount: Int;
}
