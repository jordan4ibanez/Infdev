package src.game.groups;

@:final
abstract class Groupify {
	public static function groupify(input: String): String {
		return "group:" + input;
	}
}
