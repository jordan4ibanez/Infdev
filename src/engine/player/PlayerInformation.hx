package src.engine.player;

typedef PlayerInformation = {
	var address: String;
	var ip_version: Int;
	var connection_uptime: Int;
	var protocol_version: Int;
	var formspec_version: Int;
	var lang_code: String;

	// the following keys can be missing if no stats have been collected yet
	@:optional
	var min_rtt: Float;
	@:optional
	var max_rtt: Float;
	@:optional
	var avg_rtt: Float;
	@:optional
	var min_jitter: Float;
	@:optional
	var max_jitter: Float;
	@:optional
	var avg_jitter: Float;

	// The version information is provided by the client and may be spoofed
	// or inconsistent in engine forks. You must not use this for checking
	// feature availability of clients. Instead, do use the fields
	// `protocol_version` and `formspec_version` where it matters.
	// Use `core.protocol_versions` to map Luanti versions to protocol versions.
	// This version string is only suitable for analysis purposes.
	var version_string: String; // full version string
}
