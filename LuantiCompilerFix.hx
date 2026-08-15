import haxe.Timer;
#if macro
import haxe.macro.Context;
import sys.io.File;

using StringTools;

class LuantiCompilerFix {
	// This is for testing very advanced features of the engine built on top of the luanti engine.
	// ! Debug mode only works in release compression due to the nature of how it needs to be injected.
	static final DEBUG_MODE = false;
	// This is for removing thousands of lines of code out of the lua code.
	static final RELEASE_COMPRESSION = false;

	public static function patch(fileName: String) {
		Context.onAfterGenerate(() -> {
			// This can lock up the Haxe language server so just completely ignore this thing failing to patch it if the file doesn't exist.
			final path = "mods/infdev/" + fileName;

			trace('${fileName} post-compile processing time:');
			Timer.measure(() -> {
				if (!RELEASE_COMPRESSION) {
					// This is an order of magnitude faster than release compression.
					// The string is HUGE, so do not expect miracles.
					try {
						File.saveContent(path, StringTools.replace(File.getContent(path), "package.loaded.luv", "false"));
					} catch (doNotCare) {
						trace(path + " doesn't exist. Failed to patch.");
					}
				} else {
					try {
						var content: String = File.getContent(path);
						var outputLines: Array<String> = [];

						for (i => currentLine in content.split("\n")) {
							// Hard code package.loaded.luv to short circuit into _hx_luv define.
							if (currentLine.contains("package.loaded.luv")) {
								currentLine = 'if false then';
							}

							if (DEBUG_MODE && i == 0 && fileName == "init.lua") {
								currentLine = "local compilerDebugUnsafeEnvironment = core.request_insecure_environment();";
								// trace(currentLine);
							}

							// If this line is blank, it doesn't get added to the output.
							// If this line is a comment it doesn't get added to the output either.
							var trimmedLine = currentLine.trim();
							var isComment = trimmedLine.startsWith("--");
							if (!isComment && trimmedLine.length > 0) {
								outputLines.push(trimmedLine);
							}
						}

						File.saveContent(path, outputLines.join("\n"));
					} catch (doNotCare) {
						trace(path + " doesn't exist. Failed to patch.");
					}
				}
			});
		});
	}
}
#end
