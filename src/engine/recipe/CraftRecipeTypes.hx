package src.engine.recipe;

import src.engine.compilercode.LuaArray;
import src.engine.compilercode.LuaMap;

typedef CraftRecipeShaped = {
	// todo: needs: type = "shaped"
	var recipe: LuaArray<LuaArray<String>>;

	// Defaults to 1.
	@:optional
	var amount: Int;

	@:optional
	var replacements: LuaArray<LuaArray<String>>;
}

typedef CraftRecipeShapeless = {
	// todo: needs: type = "shapeless"
	var recipe: LuaArray<String>;

	// Defaults to 1.
	@:optional
	var amount: Int;

	@:optional
	var replacements: LuaArray<LuaArray<String>>;
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
	var replacements: LuaMap<String, String>;
}

typedef CraftRecipeFuel = {
	// todo: needs: type = "fuel"
	// todo: recipe is itself
	// var recipe: String;
	var burntime: Float;

	@:optional
	var replacements: LuaMap<String, String>;
}
