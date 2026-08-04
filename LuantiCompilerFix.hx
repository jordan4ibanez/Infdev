#if macro
import haxe.macro.Context;
import sys.io.File;

using StringTools;

class LuantiCompilerFix {
	public static function patch(fileName: String) {
		Context.onAfterGenerate(() -> {
			// This can lock up the Haxe language server so just completely ignore this thing failing to patch it if the file doesn't exist.
			final path = "mods/infdev/" + fileName;
			try {
				var content: String = File.getContent(path);
				var outputLines: Array<String> = [];

				for (currentLine in content.split("\n")) {
					// Hard code package.loaded.luv to short circuit into _hx_luv define.
					if (currentLine.contains("package.loaded.luv")) {
						currentLine = 'if false then';
					}

					// If this line is blank, it doesn't get added to the output.
					if (currentLine.trim().length > 0) {
						outputLines.push(currentLine);
					}
				}

				File.saveContent(path, outputLines.join("\n"));
			} catch (doNotCare) {
				trace(path + " doesn't exist. Failed to patch.");
			}
		});
	}
}
#end
