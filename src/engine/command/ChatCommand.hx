package src.engine.command;

import haxe.extern.EitherType;
import src.engine.compilercode.LuaMap;

@:autoBuild(src.engine.compilercode.ChatCommandDuctTape.build())
interface ChatCommand {
	var params: String;
	var description: String;
	var privs: LuaMap<String, Bool>;
	var func: (name: String, param: String) -> EitherType<Void, Bool>;
}
