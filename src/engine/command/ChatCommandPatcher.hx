package src.engine.command;

@:final
abstract class ChatCommandPatcher {
	public static function patchWrapperClass(wrapperClass: Dynamic, instance: ChatCommand, registrationName: String): Void {
		wrapperClass.params = instance.params;
		wrapperClass.description = instance.description;
		wrapperClass.privs = instance.privs;

		// untyped {
		// 	 print(dump(instance));
		// 	 print(dump($i{wrapperClassName}));
		// }

		untyped __lua__("core.register_chatcommand({0}, {1})", registrationName, wrapperClass);
	}
}
