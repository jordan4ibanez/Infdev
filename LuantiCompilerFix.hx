#if macro
import sys.io.File;
import haxe.macro.Context;

using StringTools;

class LuantiCompilerFix {
	public static function blah() {
		Context.onAfterGenerate(() -> {
			var content:String = File.getContent("init.lua");

			var lines = content.split("\n");

			for (i => line in lines) {
				// Check if this thing is gonna blow up Luanti safe mode.
				if (line.contains("require") && !line.startsWith("--")) {
					lines[i] = '-- ${line}';
					trace(i, lines[i]);
				}
			}

			File.saveContent("init.lua", lines.join("\n"));
		});
	}
}
#end
