package definition.images;

enum abstract TileAnimationType(String) to String {
	var verticalFrames = "vertical_frames";
	var sheet2d = "sheet_2d";
}

@:noCompletion
interface TileAnimationDefinition {
	public var type: TileAnimationType;
}

class TileAnimationDefinitionVerticalFrames implements TileAnimationDefinition {
	public var type: TileAnimationType = TileAnimationType.verticalFrames;
	@:native("aspect_w")
	public var aspectW: Int;
	@:native("aspect_h")
	public var aspectH: Int;
	public var length: Float;

	public function new(aspectW: Int, aspectH: Int, length: Float) {
		this.aspectW = aspectW;
		this.aspectH = aspectH;
		this.length = length;
	}
}

class TileAnimationDefinitionSheet2d implements TileAnimationDefinition {
	public var type: TileAnimationType = TileAnimationType.sheet2d;
	@:native("frames_w")
	public var framesW: Int;
	@:native("frames_h")
	public var framesH: Int;
	@:native("frame_length")
	public var frameLength: Float;

	public function new(framesW: Int, framesH: Int, frameLength: Float) {
		this.framesW = framesW;
		this.framesH = framesH;
		this.frameLength = frameLength;
	}
}
