package definition;

import haxe.extern.EitherType;

typedef TileAnimation = {
	var type: String;
	var ?frames: Int;
	var ?framerate: Float;
}

enum abstract TileAnimationType(String) to String {
	var verticalFrames = "vertical_frames";
	var sheet2d = "sheet_2d";
}

typedef ImageDefinitionTable = {
	var name: String;
	var ?animation: TileAnimation;
}

interface TileAnimationDefinition {
	var type: TileAnimationType;
}

	}
}
