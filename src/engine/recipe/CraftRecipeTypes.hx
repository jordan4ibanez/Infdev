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

typedef CraftRecipeCooking = {
	var recipe: String;

	// todo: needs: type = "cooking"
	@:optional
	var cooktime: Float;

	// Defaults to 1.
	@:optional
	var amount: Int;
	// replacements? Looks very strange
}
