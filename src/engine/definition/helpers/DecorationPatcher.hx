package src.engine.definition.helpers;

@:final
abstract class DecorationPatcher {
	public static function patchClass(instance: Decoration, decoType: String): Void {
		untyped {
			instance.deco_type = decoType;
			// Auto concatenate enum table into string.
			if (instance.flags != null) {
				instance.flags = lua.Table.concat(instance.flags, ", ");
			}
			// Remove haxe metadata.
			instance.__fields__ = null;
			// print(dump(instance));
		}
		untyped __lua__("core.register_decoration({0})", instance);
	}
}
