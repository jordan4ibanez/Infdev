package engine.definition;

/**
 * When you extend this class, you get a specialty class which is extremely interesting.
 * 
 * The extended class is wrapped in a static class.
 * 
 * Defined vars are all copied to the static class. (They are virtual final)
 * 
 * Defined methods are copied to the static class and wrapped in static methods.
 * 
 * ! Warning: Do not call an override API method unless you define it. It doesn't exist.
 * 
 * Feel free to edit your custom vars during runtime.
 * 
 * Never call another override function unless 
 * 
 * Also another note: This one is for Toold. 
 * Use the ItemDefinition class for items.
 * Use the NodeDefinition class for nodes.
 */
@:luantiDefinitionRoot
class ToolDefinition extends ItemDefinition {
	public function new() {
		super();
	}
}
