import sys.FileSystem;

class Packager {
	public static function main() {
		// This is not portable but I do not care.
		// I was originally going to do something fancy but who really cares? It's running in an ubuntu container on microsoft infrastructure.

		if (FileSystem.exists("Infdev.zip")) {
			FileSystem.deleteFile("Infdev.zip");
		}

		// I literally did this so I don't have to use quotations.
		final ____components = '
			mods/
			game.conf
			LICENSE.md
			README.md
		';

		var command = "zip -r Infdev.zip";

		// Too much engineering went into this.
		for (component in StringTools.trim(____components).split("\n")) {
			component = StringTools.trim(component);
			// trace(component);
			command += ' "$component"';
		}

		trace(command);

		Sys.command(command);
	}
}
