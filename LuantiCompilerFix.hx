#if macro
import sys.io.File;
import haxe.macro.Context;

using StringTools;

class LuantiCompilerFix {
	public static function patch(fileName: String) {
		Context.onAfterGenerate(() -> {
			var content: String = File.getContent("mods/infdev/" + fileName);

			var lines = content.split("\n");

			for (i => line in lines) {
				// Hard code package.loaded.luv to short circuit into _hx_luv define.
				if (line.contains("package.loaded.luv")) {
					lines[i] = '-- Short circuit to automatic define.\nif false then';
				}

				// Check if this thing is gonna blow up Luanti safe mode.
				// if (line.contains("require") && !line.startsWith("--")) {
				// 	lines[i] = '--${line} (Disabled for Luanti.)';
				// }
			}

			File.saveContent("mods/infdev/init.lua", lines.join("\n"));
		});
	}
}
#end
