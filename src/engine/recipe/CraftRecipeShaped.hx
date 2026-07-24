package src.engine.recipe;

import lua.Table;

class CraftRecipeShaped {
	final type = "shaped";

	var recipe: Table<Int, Table<Int, String>> = Table.create();

	public function new(data: Array<Array<String>>) {
		

	}
}
