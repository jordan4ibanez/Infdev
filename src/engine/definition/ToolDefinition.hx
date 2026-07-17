package src.engine.definition;

import src.engine.compilercode.LuaMap;
import src.engine.definition.basic.MaxLevel.MAX_LEVEL;
import src.game.groups.ToolGroup;

inline final MAX_TOOL_LEVEL = MAX_LEVEL;

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
 * Also another note: This one is for tools. 
 * Use the ItemDefinition class for items.
 * Use the NodeDefinition class for nodes.
 */
@:luantiDefinitionRoot
class ToolDefinition extends ItemDefinition {
	@:native("groups")
	public var toolGroups: LuaMap<ToolGroup, Int>;

	public function new() {
		super();
	}
}
