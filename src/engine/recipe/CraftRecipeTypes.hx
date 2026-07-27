package src.engine.recipe;

import src.engine.compilercode.LuaArray;

typedef CraftRecipeShaped = {
	var recipe: LuaArray<LuaArray<String>>;

	// Defaults to 1.
	@:optional
	var amount: Int;

	@:optional
	var replacements: Map<String, String>;
}

typedef CraftRecipeShapeless = {
	var recipe: LuaArray<String>;

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
	var burntime: Float;

	@:optional
	var replacements: Map<String, String>;
}
