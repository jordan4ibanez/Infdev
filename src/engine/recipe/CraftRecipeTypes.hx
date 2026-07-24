package src.engine.recipe;

typedef CraftRecipeShaped = {
	// todo: needs: type = "shaped"
	var recipe: Array<Array<String>>;

	// Defaults to 1.
	@:optional
	var amount: Int;

	@:optional
	var replacements: Map<String, String>;
}

typedef CraftRecipeShapeless = {
	// todo: needs: type = "shapeless"
	var recipe: Array<String>;

	// Defaults to 1.
	@:optional
	var amount: Int;

	@:optional
	var replacements: Map<String, String>;
}

typedef CraftRecipeCooking = {
	// todo: needs: type = "cooking"
	var recipe: String;

	@:optional
	var cooktime: Float;

	// Defaults to 1.
	@:optional
	var amount: Int;

	@:optional
	var replacements: Map<String, String>;
}

typedef CraftRecipeFuel = {
	// todo: needs: type = "fuel"
	// todo: recipe is itself
	// var recipe: String;
	@:optional
	var burntime: Float;

	@:optional
	var replacements: Map<String, String>;
}
