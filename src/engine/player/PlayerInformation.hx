package src.engine.player;

typedef PlayerInformation = {
    var address : "127.0.0.1",     // IP address of client
    var ip_version : 4,            // IPv4 / IPv6
    var connection_uptime : 200,   // seconds since client connected
    var protocol_version : 32,     // protocol version used by client
    var formspec_version : 2,      // supported formspec version
    var lang_code : "fr",          // Language code used for translation

    // the following keys can be missing if no stats have been collected yet
    var min_rtt : 0.01,            // minimum round trip time
    var max_rtt : 0.2,             // maximum round trip time
    var avg_rtt : 0.02,            // average round trip time
    var min_jitter : 0.01,         // minimum packet time jitter
    var max_jitter : 0.5,          // maximum packet time jitter
    var avg_jitter : 0.03,         // average packet time jitter

    // The version information is provided by the client and may be spoofed
    // or inconsistent in engine forks. You must not use this for checking
    // feature availability of clients. Instead, do use the fields
    // `protocol_version` and `formspec_version` where it matters.
    // Use `core.protocol_versions` to map Luanti versions to protocol versions.
    // This version string is only suitable for analysis purposes.
    var version_string : "0.4.9-git",   // full version string

    // the following information is available in a debug build only!!!
    // DO NOT USE IN MODS
    //serialization_version = 26,     // serialization version used by client
    //major = 0,                      // major version number
    //minor = 4,                      // minor version number
    //patch = 10,                     // patch version number
    //state = "Active"                -- current client state
}